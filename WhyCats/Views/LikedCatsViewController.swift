//
//  LikedCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class LikedCatsViewController: UIViewController {
    var coordinator: LikedCatsCoordinator?
    @IBOutlet weak var likedCatsCollectionView: UICollectionView!
    @IBOutlet weak var cellFlowLayout: UICollectionViewFlowLayout!
    
    
    //    LikedCatsCollectionViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearances()
        setupCollectionView()
    }
    
    
    
    func setAppearances() {
        navigationItem.title = "Cats I Like"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarItem.image = UIImage(named: "LikedHeart")
    }
    
    
    
}


extension LikedCatsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        likedCatsCollectionView.delegate = self
        likedCatsCollectionView.dataSource = self
        
        likedCatsCollectionView.register(UINib(nibName: "LikedCatsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikedCatsCollectionViewCell")
        
        cellFlowLayout.minimumInteritemSpacing = 5
        cellFlowLayout.minimumLineSpacing = 15
        cellFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 25, bottom: 2, right: 25)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueCell = likedCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "LikedCatsCollectionViewCell", for: indexPath)
        guard let cellOne = dequeueCell as? LikedCatsCollectionViewCell else {fatalError("Wrong Cell")}
        
        return cellOne
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = cellFlowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: 160, height: 177)
    }
    
}
