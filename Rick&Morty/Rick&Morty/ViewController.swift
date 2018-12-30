//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit
import RMKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RMService().getCharactersTask(completion: {
            switch $0 {
            case .successful(let response):
                response.characters.forEach { print($0.name) }
            default: return
            }
        }).resume()
    }


}

