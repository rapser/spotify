//
//  AuthResponse.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 25-09-23.
//

import Foundation

struct AuthResponse: Codable {
    
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
    
}
