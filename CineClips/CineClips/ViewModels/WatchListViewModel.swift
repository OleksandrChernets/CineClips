//
//  WatchListViewModel.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//


import RealmSwift

import RealmSwift

class WatchListViewModel {

    var movies: [MovieRealm] = []
   
    
    // Get all movies from Realm database
    func getMovie() {
        movies = MovieDataManager.shared.getMovie()
      }
    
    // Delete a movie from the Realm database
    func deleteMovie(movie: MovieRealm) {
        MovieDataManager.shared.deleteMovie(movie: movie)
      }
}
