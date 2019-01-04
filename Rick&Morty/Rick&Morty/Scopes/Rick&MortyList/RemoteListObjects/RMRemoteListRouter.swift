//
//  RMRemoteListRouter.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

struct RMRemoteListRouter: RMListRouter {
    private weak var controller: RMListViewController?
    static func createScope() -> RMListViewController {
        let remoteListViewController = RMListViewController()
        remoteListViewController.appearence = RMRemoteListAppearence()
        let model = RMRemoteListModel()
        let router = RMRemoteListRouter(controller: remoteListViewController)
        let presenter = RMListRemotePresenter(model: model, router: router)
        remoteListViewController.presenter = presenter
        return remoteListViewController
    }
    
    init(controller: RMListViewController) {
        self.controller = controller
    }
    
    func presentClearCacheAlert(completion: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: "Warning", message: "Do you want clear cache?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            completion(true)
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: { _ in
            completion(false)
        })
        alert.addAction(yesAction)
        alert.addAction(noAction)
        controller?.present(alert, animated: true)
        
    }
}
