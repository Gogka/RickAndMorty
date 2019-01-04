//
//  RMCharacterCell.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit

class RMCharacterCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var nameLabel: UILabel!
    var characterId: Int?
    
    private let shadow: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.8
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.textColor = .white
        nameLabel?.minimumScaleFactor = 0.6
        nameLabel?.font = .systemFont(ofSize: 20)
        blurEffectView?.effect = UIBlurEffect(style: .dark)
        avatarImageView?.contentMode = .scaleAspectFill
        avatarImageView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        layer.insertSublayer(shadow, below: contentView.layer)
        clipsToBounds = false
    }

//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        shadow.removeFromSuperlayer()
//        guard let superview = self.superview else { return }
//        superview.layer.insertSublayer(shadow, below: layer)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        shadow.path = path
        shadow.shadowPath = path
    }
}
