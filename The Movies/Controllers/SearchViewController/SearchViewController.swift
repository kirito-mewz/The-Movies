//
//  SearchViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var upButton: UIButton!
    
    // MARK:  - Properties
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchText = ""
    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    
    var movies: [Movie]?
    var currentPage = 1
    var totalPages = 1
    
    let movieModel: MovieModel = MovieModelImpl.shared
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupSearchBar()
        setupUpButton()
        
    }
    
    // MARK: - Target/Action Handlers
    @IBAction func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

