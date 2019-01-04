//
//  RMListRouter.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

protocol RMListRouter {
    func presentClearCacheAlert(completion: @escaping (Bool) -> ())
}
