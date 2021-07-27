//
//  AllCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit
import CoreData
import Swinject
import Kingfisher

@available(iOS 13.0, *)
class AllCatsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var coordinator: AllCatsCoordinator?
    
    @IBOutlet weak var allCatsCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var allCatsCollectionView: UICollectionView!
    
    private let cats: CatsRepo = Container.sharedContainer.resolve(CatsRepo.self)!
    
    let catList = [CatsModel]()
    var liked: Bool?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
  
    
    
    
    lazy var catsFetchedResultController:NSFetchedResultsController<AllCatsCoreDataModel> = {
        let fetchedRequest = NSFetchRequest<AllCatsCoreDataModel>(entityName: "AllCatsCoreDataModel")
        var sdSortDate = NSSortDescriptor.init(key: "name", ascending: true)
        fetchedRequest.sortDescriptors = [sdSortDate]
        let controller = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self as NSFetchedResultsControllerDelegate
        
        do{
            try controller.performFetch()
        }catch{
            
        }
        
        return controller
    }()
    
    override func loadViewIfNeeded() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearances()
        setCollectionViewTings()
        setIndicators()
        
        if catsFetchedResultController.fetchedObjects?.count == 0 {
            catCall()
        } else {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
  
    }
    //MARK:- fetch cats from api
    func catCall() {
        
        
        self.activityIndicator.startAnimating()
        
        cats.fetchCats(completion: { response in
       
            
            if case .success(_) = response {
                print(response)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
                
            }else if case .failure(_) = response {

                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
            }else if case .error(_) = response{
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
             
            }
            
        })
    }
    
    
    func setAppearances() {
        navigationItem.title = "All Cats"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarItem.image = UIImage(named: "All Cats")
        
    }
    
    //MARK:- setup spinner activity indicator
    func setIndicators() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
}

//MARK:- collectionviews setup extension
@available(iOS 13.0, *)
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
        let url = URL(string: items.image ?? "")
        cellOne.catImageView.kf.setImage(with: url, placeholder: UIImage(named: "All Cats") )

        // set like accessory appearance
        cellOne.likeButton.tag = indexPath.row
        cellOne.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        
        if items.liked == true {
            cellOne.likeButton.setImage(UIImage(named: "RedLikedHeart"), for: .normal)
            print("liked")
            
            
        } else {
            cellOne.likeButton.setImage(UIImage(named: "unlikedHeart"), for: .normal)
            print("unliked")
            
        }
        
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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        allCatsCollectionView.reloadData()
        
    }
    

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        let items = catsFetchedResultController.fetchedObjects
        let item = items?[sender.tag]
        sender.isSelected = !sender.isSelected
        print("\(items?[sender.tag].name ?? "")")
        if item?.isLiked == false {
            item?.isLiked = true
               } else {
                item?.isLiked = false
               }
               do {
                   try CoreDataStack.shared.persistentContainer.viewContext.save()
               } catch {
       
               }
        
    }
    
    
}


