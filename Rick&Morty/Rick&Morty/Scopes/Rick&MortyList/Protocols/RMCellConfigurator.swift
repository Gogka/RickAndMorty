//
//  RMCellConfigurator.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

protocol RMCellConfigurator {
    static var identificator: String { get }
    func configure(_ cellView: UIView)
    func didTapCell()
    func prefetchData()
    func cancelPrefetchData()
}

extension RMCellConfigurator {
    func didTapCell() { }
    func prefetchData() { }
    func cancelPrefetchData() { }
}
