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
    var collectionHandler: RMListCollectionHandler = RMAdvancedCollectionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupExtraUI()
    }
    
    private func setupDependencies() {
        appearence?.setup(self)
        appearence?.localize(self)
        presenter?.attach(view: self)
        collectionHandler.attach(delegate: self)
        collectionView.map { collectionHandler.attach(collection: $0) }
    }
    
    private func setupExtraUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapRightBarButtonItem))
    }
    
    @objc
    private func didTapRightBarButtonItem() {
        presenter?.didTapRightBarButtonItem()
    }
}

extension RMListViewController: RMListView {
    func updateCollection(withConfigurators configurators: [RMCellConfigurator], isHaveMoreData: Bool) {
        collectionHandler.setIsHaveMoreData(to: isHaveMoreData)
        collectionHandler.update(withConfigurators: configurators)
    }
}

extension RMListViewController: RMListCollectionHandlerDelegate {
    func getMoreData() {
        presenter?.getMoreData()
    }
}
