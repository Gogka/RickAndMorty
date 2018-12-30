//
//  RMService.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public class RMService {
    public static let shared = RMService()
    private static let characterPath = "/api/character"
    private static let locationPath = "/api/location"
    private static let episodePath = "/api/episode"
    private static let avatarPath = "/api/character/avatar"
    
    private static let urlBase: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        return components
    }()
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    private init() { }
    
    public func getCharactersTask(forPage page: Int = 0,
                              nameFilter: String? = nil,
                              statusFilter: RMCharacter.Status? = nil,
                              speciesFilter: String? = nil,
                              typeFilter: String? = nil,
                              genderFilter: RMCharacter.Gender? = nil,
                              completion: @escaping (RMResult<RMCharactersResponse>) -> ()) -> URLSessionDataTask {
        var items = ["page": "\(page)"]
        nameFilter.map { items["name"] = $0 }
        statusFilter.map { items["status"] = $0.rawValue }
        speciesFilter.map { items["species"] = $0 }
        typeFilter.map { items["type"] = $0 }
        genderFilter.map { items["gender"] = $0.rawValue }
        let url = RMService.urlBase
            .add(path: RMService.characterPath)
            .add(queryItems: items).url!
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let sSelf = self else {
                completion(.error(.unknown))
                return
            }
            completion(sSelf.parse(data: data, response: response, error: error))
        }
        return task
    }
    
    public func loadAvatar(forIdentificator id: String, completion: @escaping (RMResult<UIImage>) -> ()) -> URLSessionDataTask {
        let url = RMService.urlBase.add(path: RMService.avatarPath + "/" + id).url!
        let task = session.dataTask(with: url) { (data, response, error) in
            if (response as? HTTPURLResponse)?.statusCode == 429 {
                completion(.error(.queryLimit))
                return
            }
            if let errorUnwrapped = error {
                completion(.error(.withDescription(errorUnwrapped.localizedDescription)))
                return
            }
            guard let dataUnwrapped = data else {
                completion(.error(.noData))
                return
            }
            guard let avatar = UIImage(data: dataUnwrapped) else {
                completion(.error(.parsing))
                return
            }
            completion(.successful(avatar))
        }
        return task
    }
    
    private func parse<Object: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> RMResult<Object> {
        if (response as? HTTPURLResponse)?.statusCode == 429 {
            return .error(.queryLimit)
        }
        if let errorUnwrapped = error {
            return .error(.withDescription(errorUnwrapped.localizedDescription))
        }
        guard let dataUnwrapped = data else {
            return .error(.noData)
        }
        guard let rmResponse = try? JSONDecoder().decode(Object.self, from: dataUnwrapped) else {
            return .error(.parsing)
        }
        return .successful(rmResponse)
    }
}
