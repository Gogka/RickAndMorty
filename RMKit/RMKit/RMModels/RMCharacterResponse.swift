//
//  RMCharacterResponse.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public class RMCharactersResponse: RMResponse {
    public let characters: [RMCharacter]
    
    enum Keys: String, CodingKey {
        case characters = "results"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        characters = try container.decode([RMCharacter].self, forKey: .characters)
        try super.init(from: decoder)
    }
}

public class RMInfo: Decodable {
    public let total: Int
    public let pagesCount: Int
    public let previousPage: Int?
    public let nextPage: Int?
    
    enum Keys: String, CodingKey {
        case total = "count"
        case pagesCount = "pages"
        case next, prev
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        total = try container.decode(Int.self, forKey: .total)
        pagesCount = try container.decode(Int.self, forKey: .pagesCount)
        let nextPageSting = try container.decode(String.self, forKey: .next)
        let prevPageSting = try container.decode(String.self, forKey: .prev)
        nextPage = URLComponents(string: nextPageSting)?.queryItems?.first(where: { $0.name == "page" })?.value.map { Int($0) } ?? nil
        previousPage = URLComponents(string: prevPageSting)?.queryItems?.first(where: { $0.name == "page" })?.value.map { Int($0) } ?? nil
    }
}

public class RMResponse: Decodable {
    public let info: RMInfo
}
