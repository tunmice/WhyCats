//
//  AllCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class AllCatsViewController: UIViewController {
    var coordinator: AllCatsCoordinator?
    
    @IBOutlet weak var allCatsCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var allCatsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setAppearances()
        setCollectionViewTings()
    }
    func setAppearances() {
        navigationItem.title = "All Cats"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarItem.image = UIImage(named: "All Cats")

    }

    

}

extension AllCatsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setCollectionViewTings() {
        allCatsCollectionView.delegate = self
        allCatsCollectionView.dataSource = self
        allCatsCollectionView.register(UINib(nibName: "AllCatsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllCatsCollectionViewCell")
        
        allCatsCollectionFlowLayout.minimumInteritemSpacing = 5
        allCatsCollectionFlowLayout.minimumLineSpacing = 15
        allCatsCollectionFlowLayout.sectionInset = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueCell = allCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "AllCatsCollectionViewCell", for: indexPath)
        guard let cellOne = dequeueCell as? AllCatsCollectionViewCell else {fatalError("Wrong Cell")}
        
            return cellOne
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = collectionView.bounds.width
          let numberOfItemsPerRow: CGFloat = 1
          let spacing: CGFloat = allCatsCollectionFlowLayout.minimumInteritemSpacing
          let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
          let itemDimension = floor(availableWidth / numberOfItemsPerRow)
          return CGSize(width: itemDimension, height: 55)
      }
    
   
}
