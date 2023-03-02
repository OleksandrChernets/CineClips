//
//  File.swift
//  CineClips
//
//  Created by Alexandr Chernets on 23.02.2023.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    //MARK: Trendnig Movies
    func getTrendingMovies(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)trending/movie/day?api_key=\(APIs.apiKey.rawValue)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
                
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    //MARK: Trending TV
    func getTrendingTV(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)trending/tv/day?api_key=\(APIs.apiKey.rawValue)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
                
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    //MARK: Popular Movies
    func getPopularMovies(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)movie/popular?api_key=\(APIs.apiKey.rawValue)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
        
    }
    
    //MARK: Popular TV
    func getPopularTV(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)tv/popular?api_key=\(APIs.apiKey.rawValue)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
        
    }
    
    //MARK: Upcoming movies
    func getUpcoming(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)movie/upcoming?api_key=\(APIs.apiKey.rawValue)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
        
    }
    
    //MARK: Top rated movies
    func getTopRated(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)movie/top_rated?api_key=\(APIs.apiKey.rawValue)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
        
    }
    
    //MARK: Reccommended Movies
    func getRecommendedMovies(compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIs.baseURL.rawValue)movie/now_playing?api_key=\(APIs.apiKey.rawValue)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    //MARK: Search request
    func search(with query: String,  compltetion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(APIs.baseURL.rawValue)search/movie?api_key=\(APIs.apiKey.rawValue)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MediaResponse.self, from: data)
                compltetion(.success(results.results))
            } catch {
                compltetion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    //MARK: Movie trailer request
    func getMovieTrailer(with query: String, completion: @escaping (MovieTrailer) -> ())  {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(APIs.baseURL.rawValue)movie/\(query)/videos?api_key=\(APIs.apiKey.rawValue)&language=en-US") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieTrailers.self, from: data)
                if let trailer = results.results.last {
                    completion(trailer)
                }
                
            } catch {
                
            }
        }
        task.resume()
    }
    
    //MARK: TV trailer request
    func getTVTrailer(with query: String, completion: @escaping (MovieTrailer) -> ())  {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(APIs.baseURL.rawValue)tv/\(query)/videos?api_key=\(APIs.apiKey.rawValue)&language=en-US") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieTrailers.self, from: data)
                if let trailer = results.results.last {
                    completion(trailer)
                }
            } catch {
                
            }
            
        }
        task.resume()
    }
}

enum APIError: Error {
    case failedToGetData
}

// MARK: - Video type
enum VideoType: String {
    case movie
    case tv
}
// MARK: - Request methods
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: - Error of search
enum SearchError: Error {
    case underlyingError(Error)
    case notFound
    case unkowned
}
// MARK: - Media type
enum MediaType: String {
    case tv
    case movie
    case movies
}
