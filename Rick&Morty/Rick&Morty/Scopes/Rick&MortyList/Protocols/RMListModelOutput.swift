//
//  RMListModelOutput.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/31/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation
import RMKit

protocol RMListModelOutput: class {
    func didReceiveCharactersListResult(_ result: RMResult<([RMCharacter], Bool)>)
}
