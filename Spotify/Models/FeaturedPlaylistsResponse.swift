//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 26-09-23.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: [PlayListResponse]
}

struct PlayListResponse: Codable {
    let items: [PlayList]
}

struct PlayList: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
    
}
