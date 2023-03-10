//
//  Constans.swift
//  CineClips
//
//  Created by Alexandr Chernets on 30.01.2023.
//

import UIKit


// MARK: APIs path and constans
enum APIs: String {
    case apiKey = "d25ed297ac8f5f5e54eef6caa0ee45d5"
    case baseURL = "https://api.themoviedb.org/3/"
    case newToken = "https://api.themoviedb.org/3/authentication/token/new"
    case validateToken = "https://api.themoviedb.org/3/authentication/token/validate_with_login"
    case createSessionId = "https://api.themoviedb.org/3/authentication/session/new"
    case account = "https://api.themoviedb.org/3/account"
    case guestSessionID = "https://api.themoviedb.org/3/authentication/guest_session/new"
    case session = "https://api.themoviedb.org/3/authentication/session"
    case keyForVideos = "/videos?api_key=d25ed297ac8f5f5e54eef6caa0ee45d5&language=en-US"
    case defaultYoutubePath = "https://www.youtube.com/watch?v="
    
    
    // MARK: Responce check func
    static func checkResponce(_ data: Data?, _ responce: URLResponse?, _ error: Error?, completionHandler: @escaping (Data) -> Void) {
        if error != nil {
            print("error")
        } else if let resp = responce as? HTTPURLResponse,
                  resp.statusCode/200 == 1, let responceData = data {
            completionHandler(responceData)
        }
    }
}

