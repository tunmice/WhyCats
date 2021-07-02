//
//  AllCatsCollectionViewCell.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

protocol MyCellDelegate : NSObjectProtocol {
    func optionButton1DidToggle(in cell: UICollectionViewCell?)
}

class AllCatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catName: UILabel!
    
    @IBOutlet weak var catImageView: UIImageView!
    
    var delegate : MyCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        likeButton.isSelected = false
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
