//
//  AccountModels.swift
//  CineClips
//
//  Created by Alexandr Chernets on 30.01.2023.
//

// MARK: - Account
struct Account: Codable {
    let avatar: Avatar
    let id: Int
    let iso6391, iso31661, name: String
    let includeAdult: Bool
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

// MARK: Gravatar
struct Gravatar: Codable {
    let hash: String
}

// MARK: Tmdb
struct Tmdb: Codable {
    let avatarPath: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

// MARK: Encode/decode helpers
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self,
                                             DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
