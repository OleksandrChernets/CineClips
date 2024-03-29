//
//  HomeViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 15.01.2023.
//

import UIKit


// MARK: Title For Header In Section
enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case PopularMovies = 2
    case PopularTV = 3
    case Upcoming = 4
    case TopRated = 5
}

final class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainMovieAverage: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var playMovieButton: UIButton!
    
    // MARK: - Properties
    var movies: [Movie] = [Movie]()
    private var randomMovie: Movie?
    private var randomMainViewMovie: Movie?
    var homeViewModel: HomeViewModel = HomeViewModel()
    let sectionTitle: [String] = ["Trending Movies",
                                  "Trending TV",
                                  "Popular Movies",
                                  "Popular TV",
                                  "Upcoming",
                                  "Top Rated"]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        configureMainImage()
        configureImageUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeTableView.setContentOffset(.zero, animated: true)
    }
    
    // MARK: - @IBActions
    @IBAction func playMovieButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.viewModel.movie = randomMainViewMovie
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private Methods
    // Fetch the random movie from API and configure the main image view
    private func configureMainImage() {
        APICaller.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    let selectedMovie = movies.randomElement()
                    self?.randomMovie = selectedMovie
                    self?.randomMainViewMovie = selectedMovie
                    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(selectedMovie?.poster_path ?? "")")
                    else {
                        return
                    }
                    self?.mainImageView.sd_setImage(with: url)
                    self?.releaseDate.text = selectedMovie?.release_date ?? ""
                    self?.movieLabel.text = selectedMovie?.original_name ?? selectedMovie?.original_title ?? ""
                    self?.mainMovieAverage.text = "\(selectedMovie?.vote_average ?? 7.5) (\(selectedMovie?.vote_count ?? 130) reviews)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Configure the main image view with gradient layer
    private func configureImageUI() {
        mainImageView.alpha = 0.7
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = mainImageView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        mainImageView.layer.addSublayer(gradientLayer)
        mainImageView.layer.mask = gradientLayer
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        cell.layer.cornerRadius = 15
        homeViewModel.getData(for: indexPath.section, in: cell)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

// MARK: CollectionTableViewCellDelegate
extension HomeViewController: CollectionTableViewCellDelegate {
    func tableViewCellDelegate(movie: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.viewModel.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
