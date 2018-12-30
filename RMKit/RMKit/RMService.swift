//
//  RMService.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public class RMService {
    private static let characterPath = "/api/character"
    private static let locationPath = "/api/location"
    private static let episodePath = "/api/episode"
    
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
    
    public init() { }
    
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
        let url = RMService.urlBase.add(path: RMService.characterPath).add(queryItems: items).url!
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
            guard let rmResponse = try? JSONDecoder().decode(RMCharactersResponse.self, from: dataUnwrapped) else {
                completion(.error(.parsing))
                return
            }
            completion(.successful(rmResponse))
        }
        return task
    }
}
