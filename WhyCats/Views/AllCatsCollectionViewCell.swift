//
//  AllCatsCollectionViewCell.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class AllCatsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.setImage(UIImage(named: "RedLikedHeart"), for: .selected)
//            sender.setBackgroundImage(UIImage(named: "RedLikedHeart"), for: .selected)
        } else {
            sender.setImage(UIImage(named: "unlikedHeart"), for: .normal)
        }
    }
}
