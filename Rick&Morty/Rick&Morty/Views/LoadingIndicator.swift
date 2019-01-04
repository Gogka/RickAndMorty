//
//  LoadingIndicator.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 1/2/19.
//  Copyright © 2019 igortomilin. All rights reserved.
//

import UIKit

class LoadingIndicator: UIView {
    private let circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 2
        return layer
    }()
    
    private var rotateAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 0.6
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = .greatestFiniteMagnitude
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = bounds
        circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                        radius: min(bounds.width, bounds.height) / 2,
                                        startAngle: -(.pi / 3),
                                        endAngle: 4 * .pi / 3,
                                        clockwise: true).cgPath
    }
    
    func startAnimation() {
        circleLayer.add(rotateAnimation, forKey: "rotate")
    }
    
    func stopAnimation() {
        circleLayer.removeAnimation(forKey: "rotate")
    }
}
