//
//  RMRemoteListAppearence.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

struct RMRemoteListAppearence: RMListAppearence {
    func localize(_ controller: RMListViewController) {
        controller.navigationItem.title = "Characters"
    }
    
    func setup(_ controller: RMListViewController) {
        controller.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    }
}
