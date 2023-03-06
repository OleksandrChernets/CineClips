//
//  SearchViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 15.01.2023.
//

import UIKit



class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private var titles: [Movie] = [Movie]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Search for a Movies or a TV Shows"
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDiscoverMovies()
        collectionView.setContentOffset(.zero, animated: true)
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        navigationController?.navigationBar.tintColor = .white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func fetchDiscoverMovies() {
        // Use the APICaller.shared to get recommended movies
        APICaller.shared.getRecommendedMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        let model = MoviePosterURL(posterURL: title.poster_path ?? title.backdrop_path ?? "")
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itm = titles[indexPath.row]
        collectionViewCellDelegate(movie: itm)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        CGSize(width: 122, height: 180)
    }
}

// MARK: - Search Results Updating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2 else {return}
        self.collectionView.reloadData()
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    self.titles = titles
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Search Collection View Cell Delegate

extension SearchViewController: SearchCollectionViewCellDelegate {
    func collectionViewCellDelegate(movie: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.viewModel.movie = movie
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
