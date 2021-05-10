//
//  In-depthAlbumView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 25/04/2021.
//

import SwiftUI

struct MusicBrainzAPI: Codable {
    var releases: [Release]
}

struct Release: Codable, Hashable {
    let id, title: String
}

struct ArtistCredit: Codable, Hashable {
    var name: String
}


struct SingleAlbum: Codable {

    var media: [Media]
    
}

struct Media: Codable, Hashable {
    
    var tracks: [Track]
}
    
struct Track: Codable, Hashable {
    
    var number, id, title: String
    
}

struct AlbumCover: Codable {
    var results: [SingleImage]
}

struct SingleImage: Codable, Hashable {
    var artworkUrl100: String
}


