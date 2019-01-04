//
//  RMCollectionLayoutAttributes.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/4/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import UIKit

class RMCollectionLayoutAttributes: UICollectionViewLayoutAttributes {
    var parallax = CGAffineTransform.identity
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copied = super.copy(with: zone) as? RMCollectionLayoutAttributes else { return super.copy(with: zone) }
        copied.parallax = parallax
        return copied
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? RMCollectionLayoutAttributes else { return false }
        return otherAttributes.parallax == parallax
    }
}
