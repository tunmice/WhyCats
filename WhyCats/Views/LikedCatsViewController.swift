//
//  LikedCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit
import CoreData
import Swinject


class LikedCatsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var coordinator: LikedCatsCoordinator?
    @IBOutlet weak var likedCatsCollectionView: UICollectionView!
    @IBOutlet weak var cellFlowLayout: UICollectionViewFlowLayout!
    
    
    //    LikedCatsCollectionViewCell
    
    
    lazy var catsFetchedResultController:NSFetchedResultsController<AllCatsCoreDataModel> = {
        let fetchedRequest = NSFetchRequest<AllCatsCoreDataModel>(entityName: "AllCatsCoreDataModel")
        var sdSortDate = NSSortDescriptor.init(key: "name", ascending: true)
//        let firstPredicate = NSPredicate(format: "conversationcode == %@", self.conversation_code)
        let predicate = NSPredicate(format: "liked == %@", NSNumber(value: true))
        fetchedRequest.sortDescriptors = [sdSortDate]
        fetchedRequest.predicate = predicate
        let controller = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self as NSFetchedResultsControllerDelegate
        
        do{
            try controller.performFetch()
        }catch{
            
        }
        
        return controller
    }()
    
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
        catsFetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueCell = likedCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "LikedCatsCollectionViewCell", for: indexPath)
        guard let cellOne = dequeueCell as? LikedCatsCollectionViewCell else {fatalError("Wrong Cell")}
        let items = catsFetchedResultController.object(at: indexPath)
        let url = URL(string: items.image ?? "")
        cellOne.catImageView.kf.setImage(with: url)
        cellOne.catName.text = items.name
        
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
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("Message Data Reloaded")
//
        likedCatsCollectionView.reloadData()
     
    }
}
