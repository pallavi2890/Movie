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
    private var listSearchValue = [SearchData]()
    var resultsFromLocalDB = [SearchMO]()
    var entitySearch: SearchMO!
    
    var searchResults = [SearchMO]()
    var searchController: UISearchController!
    var fetchResultController: NSFetchedResultsController<SearchMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objMovieViewModel = MovieViewModel()
        
        self.title = "Movie List"
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
        
        callMoviListAPI(searchMovie: "Marvel")
    }

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
    

    // MARK: - fetch Movie List
    func callMoviListAPI(searchMovie : String)  {
        objMovieViewModel?.getAPIData(param: ["apikey":Constants.APIKeys.kAPIKey,"s" : searchMovie, "type" : "movie"], completion: { (model, error) in
            if let _ = error {

                print("error = \(error?.message ?? "")")
            }
            else {
                if let movieModel = model {
                        self.listSearchValue = movieModel.Search
                        self.saveResponseIntoLocalDB(array: movieModel.Search)
                    
                                        DispatchQueue.main.async {
                                            self.collectionView?.reloadData()
                                        }
                }
                
            }
        })
    }
  
   
    
    // MARK: - Search methods
    
    func filterContent(for searchText: String) -> Bool{
        searchResults = resultsFromLocalDB.filter({ (Movie) -> Bool in
            if let name = Movie.title
                 {
                
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
        return false
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if (searchController.searchBar.text?.count)! > 2 {
            if (filterContent(for: searchText)) {
                fetchDataFromLocalDB()
            }
            else{
            callMoviListAPI(searchMovie: searchText)
            }
            
        }
        
    }
    
    //MARK : - SAVE RESPONSE INTO LOCAL DB
    func saveResponseIntoLocalDB(array : [SearchData]) {
        
            _ = array.map{self.saveObjectSearchIntoDB(dictionary: $0)}
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        
    }
    
    private func saveObjectSearchIntoDB(dictionary: SearchData) -> NSManagedObject? {
        
        //Saving search object into DB
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            entitySearch = SearchMO(context: appDelegate.persistentContainer.viewContext)
            entitySearch.title = dictionary.Title
            entitySearch.imdbID = dictionary.imdbID
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
                    resultsFromLocalDB = fetchedObjects
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
    
    //MARK: - NAVIGATE TO DETAIL VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as! MovieDetailViewController
                destinationController.imgID = self.listSearchValue[indexPaths[0].row].imdbID
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
}
