//
//  LoadingView.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/2/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    private let indicator = LoadingIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalTo: indicator.heightAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func startAnimation() {
        indicator.startAnimation()
    }
    
    func stopAnimation() {
        indicator.stopAnimation()
    }
}
