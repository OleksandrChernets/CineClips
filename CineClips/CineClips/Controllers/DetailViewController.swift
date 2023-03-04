//
//  DetailViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 18.02.2023.
//

import UIKit
import youtube_ios_player_helper


//protocol DetailViewControllerDelegate: AnyObject {
//    func saveMovie(movie: Movie)
//}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var addToWatchListButton: UIButton!
    @IBOutlet weak var voteCount: UILabel!
    var viewModel = MovieDetailViewModel()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        ytPlayerView.layer.masksToBounds = true
        ytPlayerView.layer.cornerRadius = 20
        loadTrailers()
        
    }
    
    @IBAction func addToWatchListButtonPressed(_ sender: Any) {
        viewModel.saveMovieToRealm(movie: viewModel.movie)
        addToWatchListButton.setImage(UIImage(named: "heart.fill"), for: .normal)
        
    }
   
   
    private func loadTrailers() {
        
        // MARK: Load TV trailer
        viewModel.getTVTrailer { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ytPlayerView.load(withVideoId: self.viewModel.trailerId ?? "")
            }
        }
        // MARK: Load Movie trailer
        
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







