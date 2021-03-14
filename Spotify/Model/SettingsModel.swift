//
//  SettingsModel.swift
//  Spotify
//
//  Created by miguel tomairo on 3/13/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
