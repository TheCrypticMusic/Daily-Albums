//
//  SingleAbumView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 25/04/2021.
//

import SwiftUI



struct SingleAlbumView: View {
    
    @ObservedObject var searchAlbumRecords = SingleAlbumModel()
    
    
    
    var albums: AlbumsItem
    
    var body: some View {
        
        VStack {
            
            Text("\(albums.album)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            
            if searchAlbumRecords.albumCover.isEmpty {
                LoadingView()
                
   
            }
            else {
                AlbumCoverView(url: "\(searchAlbumRecords.albumCover[0].artworkUrl100)", placeholder: "placeholder")
                
            }
            Text("\(albums.artist)")
                .font(.title2)
            
            List {
                
                ForEach(searchAlbumRecords.searchAlbumRecords, id: \.self) { album in
                    
                    ForEach(album.tracks, id: \.self) { track in
                        
                        HStack {
                            
                            Text(track.number)
                            
                            Text(track.title)
                            
                        }
                        
                    }
                }
            }.onAppear(perform: {
                searchAlbumRecords.loadData(album:albums.album, artist: albums.artist)
            })
        }
    }
}




struct SingleAbumView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        NavigationView {
            SingleAlbumView(searchAlbumRecords: SingleAlbumModel(), albums: AlbumsItem(album: "In Love", artist: "Peace", year: 2003))
            
        }
    }
}

