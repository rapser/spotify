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
                    
//                    let jsonData = try JSONSerialization.data(withJSONObject: result, options:.prettyPrinted)
//                    let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
//                    print(jsonString)
                    
                } catch {
                    completion(.failure(error))
                }

            }
            
            task.resume()
        }
    }
    
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
