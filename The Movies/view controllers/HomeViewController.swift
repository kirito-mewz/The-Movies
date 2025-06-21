//
//  ViewController.swift
//  The Movies
//
//  Created by PaingHtet on 20/06/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMoviesTableViewCell.self].forEach {
            moviesTableView.register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
    }

}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
        case 1:
            return dequeueTableViewCell(ofType: PopularMoviesTableViewCell.self, with: tableView, for: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
        
    }
    
}
