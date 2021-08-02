//
//  MovieCollectionViewController.swift
//  Movie
//
//  Created by Pallavi Agarwal on 31/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "MovieCollectionViewCell"

class MovieCollectionViewController: UICollectionViewController,UISearchResultsUpdating,NSFetchedResultsControllerDelegate {
    
   
    public var objMovieViewModel: MovieViewModel?
    private var listSearchValue = [Search]()
    var searchResultsFromLocalDB = [SearchMO]()
    var entitySearch: SearchMO!

    var searchController: UISearchController!
    var fetchResultController: NSFetchedResultsController<SearchMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objMovieViewModel = MovieViewModel()
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        // Configure the layout and item size
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 170, height: 230)
            layout.estimatedItemSize = .zero
            layout.minimumInteritemSpacing = 0
        }
        
        // Adding the search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie..."
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        self.navigationItem.searchController = searchController
        
        collectionView.dataSource = self
        
        callMoviListAPI(searchMovie: "Avengers")
       // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return self.listSearchValue.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell

        // Configure the cell
        let result = self.listSearchValue[indexPath.row]
        cell?.configure(imageURL: result.Poster, title: result.Title)

        return cell ?? UICollectionViewCell()
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    // fetch Movie List
    func callMoviListAPI(searchMovie : String)  {
        //searchText = "Avengers"
        objMovieViewModel?.getAPIData(param: ["apikey":Constants.APIKeys.kAPIKey,"s" : searchMovie, "type" : "movie"], completion: { (model, error) in
            if let _ = error {
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
//                    self.present(alert, animated: true, completion: nil)
//                }
                
                print("error = \(error?.message ?? "")")
            } else {
                if let moviModel = model {
                                        self.listSearchValue = moviModel.Search
                    //print("MovieModel Response = \(moviModel.Response)")
//                    if moviModel.Response {
//                        self.saveResponseIntoLocalDB(array: moviModel.Search)
//                    }
                    
                                        DispatchQueue.main.async {
                                            self.collectionView?.reloadData()
                                        }
                    print("movie data = \(moviModel.Search)")
                }
                
            }
        })
    }
  
   
    


    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        print(searchText)
        if !searchText.isEmpty {
           // callMoviListAPI(searchMovie: searchText)
            callMoviListAPI(searchMovie: "Avengers")
            
        }
        
    }
    
    func saveResponseIntoLocalDB(array : [Search]) {
        
            _ = array.map{self.saveObjectSearchIntoDB(dictionary: $0)}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        
    }
    
    private func saveObjectSearchIntoDB(dictionary: Search) -> NSManagedObject? {
        
        //Saving search object into DB
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            entitySearch = SearchMO(context: appDelegate.persistentContainer.viewContext)
            entitySearch.title = dictionary.Title
            entitySearch.imdbID = Int16(dictionary.imdbID)
            entitySearch.poster = dictionary.Poster
            entitySearch.year = dictionary.Year
            entitySearch.type = dictionary.Type
            return entitySearch
        }
        return nil
    }
    
    func fetchDataFromLocalDB()  {
        let fetchRequest: NSFetchRequest<SearchMO> = SearchMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    searchResultsFromLocalDB = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //MARK - Warning Pallavi see before release
        //collectionView.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>, completion: //<#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        collectionView.reloadData()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //MARK - Warning Pallavi see before release
       // tableView.endUpdates()
        
    }
}
