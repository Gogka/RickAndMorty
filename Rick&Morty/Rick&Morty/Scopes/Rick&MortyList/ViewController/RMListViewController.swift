//
//  RMListViewController.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

class RMListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var appearence: RMListAppearence?
    var presenter: RMListPresenter?
    var collectionHandler: RMListCollectionHandler = RMStandartCollectionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearence?.setup(self)
        appearence?.localize(self)
        presenter?.attach(view: self)
        collectionHandler.attach(delegate: self)
        collectionView.map { collectionHandler.attach(collection: $0) }
    }
}

extension RMListViewController: RMListView {
    func updateCollection(withConfigurators configurators: [RMCellConfigurator]) {
        collectionHandler.update(withConfigurators: configurators)
    }
}

extension RMListViewController: RMListCollectionHandlerDelegate {
    func getMoreData() {
        presenter?.getMoreData()
    }
}
