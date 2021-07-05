//
//  AllCatsCollectionViewCell.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit



class AllCatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catName: UILabel!
    
    @IBOutlet weak var catImageView: UIImageView!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        catImageView.layer.cornerRadius = 10
        likeButton.isUserInteractionEnabled = false
    }
    
  
//    @objc func handleLike() {
//        
//    }
//
//   
//    @IBAction func likeTapped(_ sender: UIButton) {
//   
//    }
}
