//
//  APICaller.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 25-09-23.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), 
                      type: .GET)
        { (request) in
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(result)
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(error))
                }

            }
            
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse,Error>)) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=1"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                    
                }catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse,Error>)) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=2"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
            
        }
    }
    
    public func getRecomendations(genres: Set<String>, completion: @escaping ((Result<String,Error>)) -> Void) {
        
        let seeds = genres.joined(separator: ",")
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print(result)
//                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecomendationsGenres(completion: @escaping ((Result<RecommendedGenresResponse,Error>)) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result =
                    try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Private
    
    enum APIError: Error {
        case failedToGetData
    }

    enum HTTPMethod: String {
        case POST
        case GET
        case PUT
        case DELETE
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void){
        
        AuthManager.shared.withValidToken { (token) in
            
            guard let apiURL = url else {return}
            var request = URLRequest(url: apiURL)
            
            request.setValue("Bearer \(token)", 
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
            
        }
    }
}
