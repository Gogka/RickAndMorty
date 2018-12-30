//
//  RMStandartCollectionHandler.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/31/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

class RMStandartCollectionHandler: NSObject, RMListCollectionHandler {
    private weak var collection: UICollectionView?
    private var configurators = [RMCellConfigurator]()
    func attach(collection: UICollectionView) {
        self.collection = collection
        collection.register(UINib(nibName: "RMCharacterCell", bundle: .main),
                            forCellWithReuseIdentifier: RMStandartCellConfigurator.identificator)
        collection.delegate = self
        collection.dataSource = self
        if #available(iOS 10.0, *) {
            collection.prefetchDataSource = self
            collection.isPrefetchingEnabled = true
        }
    }
    
    func update(withConfigurators configurators: [RMCellConfigurator]) {
        self.configurators += configurators
        collection?.reloadData()
    }
    
    
}

extension RMStandartCollectionHandler: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configurators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configurators[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).identificator, for: indexPath)
        configurator.configure(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 200)
    }
}

extension RMStandartCollectionHandler: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach({ configurators[$0.row].prefetchData() })
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach({ configurators[$0.row].cancelPrefetchData() })
    }
}
