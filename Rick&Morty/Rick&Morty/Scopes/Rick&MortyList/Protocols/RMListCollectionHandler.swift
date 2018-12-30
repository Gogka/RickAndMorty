//
//  RMListCollectionHandler.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation
import class UIKit.UICollectionView

protocol RMListCollectionHandler {
    func attach(collection: UICollectionView)
    func update(withConfigurators configurators: [RMCellConfigurator])
}
