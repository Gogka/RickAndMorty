//
//  RMResult.swift
//  RMKit
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

public enum RMResult<Object> {
    case successful(Object)
    case error(RMError)
}
