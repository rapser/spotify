//
//  UserProfile.swift
//  Spotify
//
//  Created by miguel tomairo on 3/12/21.
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
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterLocked, filterEnabled: Bool?
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Followers
struct Followers: Codable {
    let total: Int?
    let href: String?
}

// MARK: - Image
struct UserImage:Codable {
    let url: String?
    let width, height: Double?
}
