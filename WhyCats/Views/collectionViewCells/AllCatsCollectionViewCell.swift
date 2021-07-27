//
//  AllCatsCollectionViewCell.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

protocol  LikedCatCellDelegate: AnyObject {
    func didTapLikeButton(with title: String)
}


class AllCatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var catName: UILabel!
    
    @IBOutlet weak var catImageView: UIImageView!
   
    var delegate: LikedCatCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        catImageView.layer.cornerRadius = 10

    }
    
   
    @IBAction func likeTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(with: catName.text ?? "")
    }
}
