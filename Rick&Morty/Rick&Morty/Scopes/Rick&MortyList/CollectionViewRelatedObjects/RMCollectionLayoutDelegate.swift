//
//  RMCollectionLayoutDelegate.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/4/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import UIKit

protocol RMCollectionLayoutDelegate: class {
    func layout(_ layout: RMCollectionLayout, itemSizeForIndexPath: IndexPath) -> CGSize
    func spaceBetweenCells(for layout: RMCollectionLayout) -> CGFloat
    func parallaxDistance(for layout: RMCollectionLayout) -> CGFloat
}
