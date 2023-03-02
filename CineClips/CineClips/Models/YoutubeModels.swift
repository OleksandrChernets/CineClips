//
//  YoutubeModels.swift
//  CineClips
//
//  Created by Alexandr Chernets on 20.02.2023.
//

import Foundation

// MARK: - VideoModel
struct MovieTrailers: Codable {
    let id: Int
    let results: [MovieTrailer]
}

struct MovieTrailer: Codable {
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}
