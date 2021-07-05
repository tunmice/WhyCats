//
//  LikedCatsCollectionViewCell.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class LikedCatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAppearances()
        
    }

    func setAppearances() {
        likeButton.isUserInteractionEnabled = false
        catImageView.layer.cornerRadius = 10
        
    }
    
}
