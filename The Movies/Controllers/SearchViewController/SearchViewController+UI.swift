//
//  SearchViewController+UI.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension SearchViewController {
    
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
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            currentPage = 1
            searchText = text
            searchMovies()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = []
        collectionView.reloadData()
    }
}
