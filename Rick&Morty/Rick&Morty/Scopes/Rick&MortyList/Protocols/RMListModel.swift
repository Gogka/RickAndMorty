//
//  RMListModel.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/31/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation

protocol RMListModel {
    func getNextCharacters()
    func attach(output: RMListModelOutput)
}
