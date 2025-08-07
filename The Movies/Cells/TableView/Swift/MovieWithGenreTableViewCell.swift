//
//  MovieWithGenreTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class MovieWithGenreTableViewCell: UITableViewCell {
    
    var genres: [GenreVO]? {
        didSet {
            genres?.removeAll(where: { vo in
                return movieDict[vo.id] == nil
            })
            
            genres?.first?.isSelected = true
            genreCollectionView.reloadData()
            
            reloadMovies(basedOn: genres?.first?.id ?? 0)
        }
    }
    
    var movies: [Movie]? {
        didSet {
            guard let data = movies else { return }
            organizeMoviesBasedOnGenre(data)
        }
    }
    
    @IBOutlet var genreCollectionView: UICollectionView!
    @IBOutlet var movieCollectionView: UICollectionView!
    
    private var movieDict: [Int: Set<Movie>] = [:]
    
    var delegate: MovieItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreCollectionView.delegate = self
        movieCollectionView.delegate = self
        
        genreCollectionView.dataSource = self
        movieCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieWithGenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return genres?.count ?? 0
        } else {
            return movies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCollectionView {
            return collectionView.dequeueCell(ofType: GenreCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
                guard let self = self else { return }
                // Pass data to the cell
                cell.genre = genres?[indexPath.row]
                // Implement on tap event
                cell.onGenreTap = { genreId in
                    self.resetGenreSection(genreId)
                    self.reloadMovies(basedOn: genreId)
                }
            }
        } else {
            let cell = collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = movies?[indexPath.row]
            return cell
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreCollectionView {
            let text = genres?[indexPath.row].genreName ?? ""
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Bold", size: 14) ?? UIFont.systemFont(ofSize: 14))
            return .init(width: textWidth + 20, height: 40)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }

    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onMovieCellTapped(movieId: movies?[indexPath.row].id ?? 0, type: .movie)
    }
    
}

extension MovieWithGenreTableViewCell {
    
    // MARK: - Private Helpers
    private func resetGenreSection(_ genreId: Int) {
        genres?.forEach { genre in
            if genre.id == genreId {
                genre.isSelected = true
            } else {
                genre.isSelected = false
            }
        }
        genreCollectionView.reloadData()
    }
    
    private func organizeMoviesBasedOnGenre(_ movies: [Movie]) {
        movies.forEach { movie in
            movie.genreIds?.forEach { genreId in
                if let _ = movieDict[genreId] {
                    movieDict[genreId]?.insert(movie)
                } else {
                    movieDict[genreId] = [movie]
                }
            }
        }
    }
    
    private func reloadMovies(basedOn genreId: Int) {
        movies = movieDict[genreId]?.map { $0 }
        movieCollectionView.reloadData()
    }
    
}
