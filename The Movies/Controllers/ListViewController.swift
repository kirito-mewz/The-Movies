//
//  ListViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class ListViewController: UIViewController, Storyboarded {
    
    enum ListType {
        case movies
        case casts
    }

    // MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var upButton: UIButton!
    
    // MARK:  - Properties
    var type: ListType = .movies
    
    var noOfCols: CGFloat = 2
    var spacing: CGFloat = 10
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = type == .movies ? "All Showcase Movies" : "All Actors"
        
        setupButton()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    private func setupButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    
    @IBAction func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }

}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .movies ? 10 : 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if type == .movies {
            return collectionView.dequeueCell(ofType: ShowcaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
        } else {
            return collectionView.dequeueCell(ofType: ActorCollectionViewCell.self, for: indexPath, shouldRegister: true)
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if type == .movies {
            let width = collectionView.frame.width - 20
            let height = (width * 9) / 16
            return .init(width: width, height: height)
        } else {
            let width = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
            let height = width + width * 0.5
            return .init(width: width, height: height)
        }
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
        if type == .movies {
            self.onMovieCellTapped()
        } else {
            self.onActorCellTapped()
        }
    }
    
    
    
}

// MARK: - Custom Delegate
extension ListViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
