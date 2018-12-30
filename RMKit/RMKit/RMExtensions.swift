//
//  RMExtensions.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

extension URLComponents {
    func add(path: String) -> URLComponents {
        var new = self
        new.path = path
        return new
    }
    
    func add(queryItems: [String: String]) -> URLComponents {
        var new = self
        new.queryItems = (self.queryItems ?? []) + queryItems.map({ URLQueryItem(name: $0, value: $1) })
        return new
    }
}

fileprivate extension String {
    var id: Int? { return components(separatedBy: "/").last.map({ Int($0) }) ?? nil }
}

extension KeyedDecodingContainer {
    func decodeIdFromString(key: K) throws -> Int {
        guard let id = try decode(String.self, forKey: key).id else { throw RMError.valueIsEmpty }
        return id
    }
    
    func decodeImageString(key: K) throws -> String {
        guard let id = try decode(String.self, forKey: key).components(separatedBy: "/").last else { throw RMError.valueIsEmpty }
        return id
    }
    
    func decodeArrayIdsFromString(key: K) throws -> [Int] {
        return try decode([String].self, forKey: key).compactMap({ $0.id })
    }
    
    func decodeIfNotEmpty(key: K) throws -> String {
        let value = try decode(String.self, forKey: key)
        if value.isEmpty { throw RMError.valueIsEmpty }
        return value
    }
}
