//
//  WatchListViewModel.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//


import RealmSwift

class WatchListViewModel {
    
    let realm = try? Realm()
    var movies: [MovieRealm] = []
   
    func getMovie() -> [MovieRealm] {
          
          var movies = [MovieRealm]()
          guard let movieResult = realm?.objects(MovieRealm.self) else { return [] }
          for movie in movieResult {
            movies.append(movie)
          }
          return movies
      }
}
