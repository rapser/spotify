//
//  RecomendationsResponse.swift
//  Spotify
//
//  Created by Miguel Angel Tomairo Mendez on 15-10-23.
//

import Foundation

struct RecomendationsResponse: Codable {
    let tracks: [AudioTrack]
}
