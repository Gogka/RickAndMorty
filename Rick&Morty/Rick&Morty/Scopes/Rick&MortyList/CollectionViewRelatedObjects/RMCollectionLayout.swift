//
//  RMCollectionLayout.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/4/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import UIKit

class RMCollectionLayout: UICollectionViewLayout {
    weak var delegate: RMCollectionLayoutDelegate?
    private var cache = [Int: RMCollectionLayoutAttributes]()
    private var contentHeight = CGFloat(0)
    
    override class var layoutAttributesClass: AnyClass { return RMCollectionLayoutAttributes.self }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        cache.removeAll(keepingCapacity: true)
        let cellsSpace = delegate?.spaceBetweenCells(for: self) ?? 10
        var y = collectionView.contentInset.top + cellsSpace
        (0..<collectionView.numberOfItems(inSection: 0))
            .lazy.map({ IndexPath(row: $0, section: 0) }).forEach {
                let attributes = RMCollectionLayoutAttributes(forCellWith: $0)
                let itemSize = delegate?.layout(self, itemSizeForIndexPath: $0) ?? CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height / 2.5)
                let origin = CGPoint(x: max(0, (collectionView.frame.width - itemSize.width) / 2), y: y)
                y += itemSize.height + cellsSpace
                attributes.frame = CGRect(origin: origin, size: itemSize)
                cache[$0.row] = attributes
        }
        contentHeight = y + collectionView.contentInset.bottom
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView else { return nil }
        let parallaxDistance = delegate?.parallaxDistance(for: self) ?? 60
        return cache.lazy.filter({ $1.frame.intersects(rect) }).map({
            let yOriginsOffset = (collectionView.bounds.midY - $1.frame.minY).truncatingRemainder(dividingBy: collectionView.frame.height)
            let parallax = (yOriginsOffset * (parallaxDistance / 2) / collectionView.frame.height )
            $1.parallax = CGAffineTransform(translationX: 0, y: parallax)
            return $1
        })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if (collectionView?.bounds ?? .zero).size != newBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true
    }
}
