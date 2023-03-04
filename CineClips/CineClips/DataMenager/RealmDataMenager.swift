//
//  RealmDataService.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//


import RealmSwift

struct MovieDataManager {
    
    static let shared = MovieDataManager()
    private let realm = try? Realm()
    private init() {}
    
    func saveMovie(movie: Movie?) {
        let movieRealm = MovieRealm()
        movieRealm.id = movie?.id ?? 0
        movieRealm.originalTitle = movie?.original_title ?? movie?.original_name ?? ""
        movieRealm.overview = movie?.overview ?? ""
        movieRealm.posterPath = movie?.poster_path ?? ""
        movieRealm.voteAverage = movie?.vote_average ?? 0
        movieRealm.originaLanguage = movie?.original_language ?? ""
        try? realm?.write {
            realm?.add(movieRealm, update: .all)
        }
    }
    
    func getMovie() -> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let movieResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in movieResults {
            movies.append(movie)
        }
        return movies
    }
}
