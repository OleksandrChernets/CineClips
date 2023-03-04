//
//  Genres.swift
//  CineClips
//
//  Created by Alexandr Chernets on 06.02.2023.
//

import Foundation

struct MediaResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    
    var id: Int?
    var media_type: String?
    var original_name: String?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var vote_count: Int?
    var release_date: String?
    var vote_average: Double?
    var first_air_date: String?
    var backdrop_path: String?
    var original_language: String?
    
}
