//
//  AlbumsView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 22/04/2021.
//

import SwiftUI

struct AlbumsView: View {
    
    @ObservedObject var albums = AlbumsListViewModel()
    @ObservedObject var searchAlbumRecords = SingleAlbumModel()
    var body: some View {
        NavigationView {
            List(albums.details, id: \.self) { album in
                AlbumRowView(albums: AlbumsItem(album: album.album, artist: album.artist, year: album.year))
                NavigationLink(
                    destination: SingleAlbumView(albums: AlbumsItem(album: album.album, artist: album.artist, year: album.year)),
                    label: {
                        Text("")
                    })
                
            }.navigationTitle("1001 Albums")
        }
    }
}


struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlbumsView()
        }
    }
}
