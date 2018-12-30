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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.textColor = .white
        nameLabel?.minimumScaleFactor = 0.6
        nameLabel?.font = .systemFont(ofSize: 20)
        blurEffectView?.effect = UIBlurEffect(style: .dark)
        avatarImageView?.contentMode = .scaleAspectFill
        avatarImageView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

}
