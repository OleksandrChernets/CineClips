//
//  RealmDataService.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//


import RealmSwift

// MARK: - Movie Data Manager

struct MovieDataManager {
    
    static let shared = MovieDataManager()
    public let realm = try? Realm()
    private init() {}
    
    // MARK: - MovieDataManager Functions
    
    func saveMovie(movie: Movie?) {
        let movieRealm = MovieRealm()
        movieRealm.id = movie?.id ?? 0
        movieRealm.originalTitle = movie?.original_title ?? movie?.original_name ?? ""
        movieRealm.overview = movie?.overview ?? ""
        movieRealm.posterPath = movie?.poster_path ?? ""
        movieRealm.voteAverage = movie?.vote_average ?? 0
        movieRealm.originaLanguage = movie?.original_language ?? ""
        movieRealm.releaseDate = movie?.release_date ?? movie?.first_air_date ?? ""
        movieRealm.voteCount = movie?.vote_count ?? 0
        try? realm?.write {
            realm?.add(movieRealm, update: .all)
        }
    }
    func getMovie() -> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let movieResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in movieResult {
            movies.append(movie)
        }
        return movies
    }
    
    func deleteMovie(movie: MovieRealm) {
        try? realm?.write {
            realm?.delete(movie)
        }
    }
}
