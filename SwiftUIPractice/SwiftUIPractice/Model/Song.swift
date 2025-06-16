//
//  Song.swift
//  SwiftUIPractice
//
//  Created by alternatifbank on 28.05.2025.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: String
    let title: String
    let artist: String
    let imageUrl: String
    let audioUrl: String
    var overlay: String
}
