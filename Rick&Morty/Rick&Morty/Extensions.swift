//
//  Extensions.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/2/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import Foundation

extension URLSessionTask {
    var wasCancelled: Bool { return (error as NSError?)?.code == NSURLErrorCancelled }
}
