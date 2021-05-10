//
//  AlbumView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 22/04/2021.
//

import SwiftUI

struct AlbumRowView: View {
    
    var albums: AlbumsItem
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text(albums.album)
                Text("\(albums.artist) - \(String(albums.year))")
                    .foregroundColor(.secondary)
            }
            
            
            
        }
    }
}


struct AlbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRowView(albums: AlbumsItem(album: "Test", artist: "Test", year: 2004))
            .previewLayout(PreviewLayout.fixed(width: 200, height: 400))
        
    }
}
