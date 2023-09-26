//
//  UserProfile.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 25-09-23.
//

import Foundation

struct UserProfile: Codable {
    let id: String?
    let explicitContent: ExplicitContent?
    let uri: String?
    let href: String?
    let product, type, displayName: String?
    let images: [UserImage]?
    let followers: Followers?
    let country, email: String?
    let externalUrls: ExternalUrls?
    
    enum CodingKeys: String, CodingKey {
        case id
        case explicitContent = "explicit_content"
        case uri
        case href
        case product
        case type
        case displayName = "display_name"
        case images
        case followers
        case country
        case email
        case externalUrls = "external_urls"
    }
}

struct ExplicitContent: Codable {
    let filterLocked, filterEnabled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case filterLocked = "filter_locked"
        case filterEnabled = "filter_enabled"
    }
}

struct ExternalUrls: Codable {
    let spotify: String?
}

struct Followers: Codable {
    let total: Int?
    let href: String?
}

struct UserImage:Codable {
    let url: String?
    let width, height: Double?
}
