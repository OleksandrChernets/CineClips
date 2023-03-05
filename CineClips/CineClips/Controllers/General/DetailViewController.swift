//
//  DetailViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 18.02.2023.
//

import UIKit
import youtube_ios_player_helper


protocol DetailViewControllerDelegate: AnyObject {
    func saveMovie(movie: Movie)
}

class DetailViewController: UIViewController {
    
    // MARK: - Cell Identifier
    static let identifier = "DetailViewController"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var addToWatchListButton: UIButton!
    @IBOutlet weak var voteCount: UILabel!
    var viewModel = MovieDetailViewModel()
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ytPlayerView.layer.masksToBounds = true
        ytPlayerView.layer.cornerRadius = 20
        loadTrailers()
        navigationController?.navigationBar.tintColor = .white
        decriptionLabel.sizeToFit()
    }
    
    // MARK: - IBActions
    
    @IBAction func addToWatchListButtonPressed(_ sender: Any) {
        viewModel.saveMovieToRealm(movie: viewModel.movie)
    }
    
    
    // MARK: - Private Methods
    
    private func loadTrailers() {
        
        //  Load TV trailer
        viewModel.getTVTrailer { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ytPlayerView.load(withVideoId: self.viewModel.trailerId ?? "")
            }
        }
        //  Load Movie trailer
        
        viewModel.getMovieTrailer { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ytPlayerView.load(withVideoId: self.viewModel.trailerId ?? "")
            }
        }
        
        // MARK: Configure UI
        viewModel.configureUI(title: titleLabel,
                              description: decriptionLabel,
                              dateLabel: dateLabel,
                              voteCount: voteCount)
    }
    
}







