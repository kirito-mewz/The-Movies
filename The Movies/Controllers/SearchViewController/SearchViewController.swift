//
//  SearchViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var upButton: UIButton!
    
    // MARK:  - Properties
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchResultItems: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    
    var searchText = ""
    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    
    var movies: [Movie]?
    var currentPage = 1
    var totalPages = 1
    
    let rxMovieModel: RxMovieModel = RxMovieModelImpl.shared
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
        
        setupSearchBar()
        setupUpButton()
        
        initObservers()
        
    }
    
    // MARK: - Target/Action Handlers
    @IBAction func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    // MARK: - Observers
    func initObservers() {
        addSearchBarObserver()
        addCollectionViewBindingObserver()
        addPaginationObserver()
        addOnTapObserver()
    }
    
    private func addSearchBarObserver() {
        searchController.searchBar.searchTextField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { value in
                if value.isEmpty {
                    self.currentPage = 1
                    self.totalPages = 1
                    self.searchResultItems.onNext([])
                } else {
                    self.rxSearchMovies(keyword: value, pageNo: self.currentPage)
                }
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    private func addCollectionViewBindingObserver() {
        searchResultItems.bind(to: collectionView.rx.items(cellIdentifier: String(describing: MovieCollectionViewCell.self), cellType: MovieCollectionViewCell.self)) {
            row, element, cell in
            cell.movie = element
        }
        .disposed(by: disposeBag)
    }
    
    private func  addPaginationObserver() {
        Observable.combineLatest(
            collectionView.rx.willDisplayCell,
            searchController.searchBar.rx.text.orEmpty
        )
        .subscribe { cellTuple, text in
            let (_, indexPath) = cellTuple
            let totalItems = try! self.searchResultItems.value().count
            let lastRow = indexPath.row == totalItems - 1
            
            if lastRow && self.currentPage <= self.totalPages {
                self.currentPage += 1
                self.rxSearchMovies(keyword: text, pageNo: self.currentPage)
            }
        } onError: { error in
            print("\(#function) \(error)")
        }
        .disposed(by: disposeBag)
    }
    
    private func addOnTapObserver() {
        collectionView.rx.itemSelected
            .subscribe { indexPath in
                let items = try! self.searchResultItems.value()
                let item = items[indexPath.row]
                let vc = MovieDetailViewController.instantiate()
                vc.movieId = item.id ?? -1
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
}

