//
//  RMCharacter.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public struct RMCharacter: Decodable {
    public enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown
    }
    
    public enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }

    public struct Location: Decodable {
        public let id: Int
        public let name: String
        
        enum Keys: String, CodingKey {
            case url = "url"
            case name = "name"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            name = try container.decodeIfNotEmpty(key: .name)
            id = try container.decodeIdFromString(key: .url)
        }
    }
    
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String?
    public let type: String?
    public let gender: Gender
    public let originLocation: Location?
    public let lastLocation: Location?
    public let avatar: String?
    public let episodes: [Int]
    
    enum Keys: String, CodingKey {
        case id, name, status, species, type, gender
        case originLocation = "origin"
        case lastLocation = "location"
        case avatar = "image"
        case episodes = "episode"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(Status.self, forKey: .status)
        species = try? container.decodeIfNotEmpty(key: .species)
        type = try? container.decodeIfNotEmpty(key: .type)
        gender = try container.decode(Gender.self, forKey: .gender)
        originLocation = try? container.decode(Location.self, forKey: .originLocation)
        lastLocation = try? container.decode(Location.self, forKey: .lastLocation)
        avatar = (try? container.decodeImageString(key: .avatar)).map({ String($0) }) ?? nil
        episodes = try container.decodeArrayIdsFromString(key: .episodes)
    }
}
