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
    private var isHaveMoreData = true
    weak var delegate: RMListCollectionHandlerDelegate?
    private let loadingView = LoadingView()
    
    private var configurators = [RMCellConfigurator]()
    
    func attach(collection: UICollectionView) {
        self.collection = collection
        collection.register(UINib(nibName: "RMCharacterCell", bundle: .main),
                            forCellWithReuseIdentifier: RMStandartCellConfigurator.identificator)
//        collection.register(UIView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loading")
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundView = configurators.isEmpty ? loadingView : nil
        if configurators.isEmpty {
            loadingView.startAnimation()
            collection.backgroundView = loadingView
        } else {
            collection.backgroundView = nil
        }
        if #available(iOS 10.0, *) {
            collection.prefetchDataSource = self
            collection.isPrefetchingEnabled = true
        }
    }
    
    func update(withConfigurators configurators: [RMCellConfigurator]) {
        guard let collection = self.collection else { return }
        let paths = (self.configurators.count...self.configurators.count + configurators.count - 1)
            .map({ IndexPath(row: $0, section: 0) })
        collection.performBatchUpdates({ [weak self] in
            guard let sSelf = self else { return }
            sSelf.configurators += configurators
            collection.insertItems(at: paths)
            }, completion: { [weak self] _ in
                guard let sSelf = self else { return }
                if configurators.isEmpty {
                    sSelf.loadingView.startAnimation()
                    collection.backgroundView = sSelf.loadingView
                } else {
                    collection.backgroundView = nil
                    sSelf.loadingView.stopAnimation()
                }
        })
    }
    
    func attach(delegate: RMListCollectionHandlerDelegate) {
        self.delegate = delegate
    }
    
    func setNoHaveMoreData(to value: Bool) {
        isHaveMoreData = false
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
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (configurators.count - 1), isHaveMoreData {
            delegate?.getMoreData()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        switch kind {
////        case UICollectionView.elementKindSectionFooter:
////            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loading", for: <#T##IndexPath#>)
////        default: fatalError("undefind king")
////        }
//    }
}

extension RMStandartCollectionHandler: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach({ configurators[$0.row].prefetchData() })
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach({ configurators[$0.row].cancelPrefetchData() })
    }
}
