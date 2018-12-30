//
//  RMRemoteListRouter.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

struct RMRemoteListRouter: RMListRouter {
    static func createScope() -> RMListViewController {
        let remoteListViewController = RMListViewController()
        remoteListViewController.appearence = RMRemoteListAppearence()
        let model = RMRemoteListModel()
        let router = RMRemoteListRouter()
        let presenter = RMListRemotePresenter(model: model, router: router)
        remoteListViewController.presenter = presenter
        return remoteListViewController
    }
}
