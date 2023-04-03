//
//  RealmModels.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//

import RealmSwift

class MovieRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var mediaType: String?
    @Persisted var originalTitle: String?
    @Persisted var overview: String?
    @Persisted var posterPath: String?
    @Persisted var voteCount: Int?
    @Persisted var releaseDate: String?
    @Persisted var voteAverage: Double?
    @Persisted var firstAirDate: String?
    @Persisted var backdropPath: String?
    @Persisted var originaLanguage: String?
}
