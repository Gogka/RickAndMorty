//
//  RMError.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public enum RMError: Error {
    case valueIsEmpty
    case queryLimit
    case parsing
    case unknown
    case noData
    case withDescription(String)
}
