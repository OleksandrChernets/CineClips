//
//  HomeViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 15.01.2023.
//

import UIKit
import SDWebImage

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case PopularMovies = 2
    case PopularTV = 3
    case Upcoming = 4
    case TopRated = 5
}


class HomeViewController: UIViewController {
    
    var titles: [Movie] = [Movie]()
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainMovieAverage: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    private var randomMovie: Movie?
    
    
    let sectionTitle: [String] = ["Trending Movies", "Trending TV", "Popular Movies", "Popular TV", "Upcoming", "Top Rated"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        configureMainImage()
        configureImageUI()
    }
    
    private func configureMainImage() {
        APICaller.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    let selectedMovie = movies.randomElement()
                    self?.randomMovie = selectedMovie
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


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        cell.layer.cornerRadius = 15
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTV.rawValue:
            APICaller.shared.getTrendingTV { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.PopularMovies.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.PopularTV.rawValue:
            APICaller.shared.getPopularTV{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcoming { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        header.textLabel?.textColor = .white
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
}
extension HomeViewController: CollectionTableViewCellDelegate {
    func tableViewCellDelegate(movie: Movie) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.viewModel.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
