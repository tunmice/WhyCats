//
//  AllCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit
import CoreData
import Swinject

class AllCatsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var coordinator: AllCatsCoordinator?
    
    @IBOutlet weak var allCatsCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var allCatsCollectionView: UICollectionView!
    
    private let cats: CatsRepo = Container.sharedContainer.resolve(CatsRepo.self)!
    
    let catList = [CatsModel]()
    
    func someAction() {
        print("I have performed ACTION")
    }
    
    lazy var catsFetchedResultController:NSFetchedResultsController<AllCatsCoreDataModel> = {
        let fetchedRequest = NSFetchRequest<AllCatsCoreDataModel>(entityName: "AllCatsCoreDataModel")
        var sdSortDate = NSSortDescriptor.init(key: "name", ascending: true)
//        let firstPredicate = NSPredicate(format: "conversationcode == %@", self.conversation_code)
        fetchedRequest.sortDescriptors = [sdSortDate]
//        fetchedRequest.predicate = firstPredicate
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
        setCollectionViewTings()
        
        if catsFetchedResultController.fetchedObjects?.count == 0 {
            callCats()
        } else {
            print("file be")
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        callCats()
    }
    
    
   
    
  

    
    
    func callCats() {

        cats.fetchCatsList()
        cats.fetchCats(completion: { response in
            
            if case let .success(data) = response {
                print(response)
                print("\(data[0])")
                DispatchQueue.main.async {
                    self.allCatsCollectionView.reloadData()
                }
                
            }else if case let .failure(errorMessage) = response {
                print("error wa o \(errorMessage)")
            }else if case let .error(error) = response{
                print("\(error?.localizedDescription ?? "")")
               
            }
            
        })
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
        catsFetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueCell = allCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "AllCatsCollectionViewCell", for: indexPath)
        guard let cellOne = dequeueCell as? AllCatsCollectionViewCell else {fatalError("Wrong Cell")}
        let items = catsFetchedResultController.object(at: indexPath)
        cellOne.catName.text = items.name ?? ""
        
        
        
//        if cellOne.likeButton.isSelected  {
//            items.liked = true
//        } else {
//            items.liked = false
//        }
//        items.isLiked = (LocalStorage.sharedInstance.get(for: .likedBoolean) != nil)
        DispatchQueue.main.async {
            if items.liked == true {
                cellOne.likeButton.setImage(UIImage(named: "RedLikedHeart"), for: .normal)
                print("liked")
                
        
            } else {
                cellOne.likeButton.setImage(UIImage(named: "unlikedHeart"), for: .normal)
                print("unliked")
                
            }
        }
        
       
//        cellOne.likeButton.
//        cellOne.likeButton.addTarget(self, action:  #selector(likeButtonTapped), for: .touchUpInside)
//        allCatsCollectionView.reloadData()
//        print("smurfs \(catList[0].name ?? "")")
        
        return cellOne
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = catsFetchedResultController.object(at: indexPath)
        if items.isLiked == false {
            items.isLiked = true
        } else {
            items.isLiked = false
        }
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = collectionView.bounds.width
          let numberOfItemsPerRow: CGFloat = 1
          let spacing: CGFloat = allCatsCollectionFlowLayout.minimumInteritemSpacing
          let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
          let itemDimension = floor(availableWidth / numberOfItemsPerRow)
          return CGSize(width: itemDimension, height: 55)
      }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("Message Data Reloaded")
//
        allCatsCollectionView.reloadData()
     
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
//        if sender.isSelected {
//            sender.setImage(UIImage(named: "RedLikedHeart"), for: .selected)
////            sender.setBackgroundImage(UIImage(named: "RedLikedHeart"), for: .selected)
//        } else {
//            sender.setImage(UIImage(named: "unlikedHeart"), for: .normal)
//        }
    }
    
   
}
