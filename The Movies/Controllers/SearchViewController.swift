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
    
    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    
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
    
    func setupSearchBar() {
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        
        let colorYellow = UIColor(named: "Color_Yellow")!
        
        if let textFieldInsiderSearchBar = searchBar.value(forKey: "searchField") as? UITextField,
            let iconView = textFieldInsiderSearchBar.leftView as? UIImageView {
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = colorYellow
        }
        
        searchBar.backgroundColor = UIColor(named: "Color_Primary")
        searchBar.tintColor = colorYellow
        searchBar.searchTextField.textColor = colorYellow
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search with keywords", attributes: [.foregroundColor: UIColor.systemGray])
    }
    
    func setupUpButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    @IBAction func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
        return CGSize(width: width, height: 250)
    }
    
    
    // Display UpButton while scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.frame.height / 2 {
            upButton.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.upButton.transform = .identity
            }
        } else {
            if upButton.transform.isIdentity {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.upButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onMovieCellTapped()
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
}

// MARK: - Custom Delegate
extension SearchViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
