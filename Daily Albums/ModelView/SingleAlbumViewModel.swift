//
//  SingleAlbumViewModel.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 25/04/2021.
//

import SwiftUI

 


class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?

    //https://itunes.apple.com/search?term=intheweesmallhours&attribute=albumTerm&entity=album
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        print(imageURL)
        URLSession.shared.dataTask(with: imageURL) {data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedData = data
            }
            
        }.resume()
    }
}


class SingleAlbumModel: ObservableObject {
    
    @Published var searchMusicBrainzResults = [Release]()
    @Published var searchAlbumRecords = [Media]()
    @Published var albumCover = [SingleImage]()
    
    // Refactor to make one API request.
    
//    func APIRequest(url: URL, model: Codable) {
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let data = data {
//
//                if let decodedResponse = try? JSONDecoder().decode(
//                    MusicBrainzAPI.self, from: data)
//
//                {
//                    DispatchQueue.main.async {
//                        self.searchMusicBrainzResults = decodedResponse.releases
//
//                    }
//                    return
//                }
//            }
//
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//
//        }.resume()
//        }
//    }
    
    func loadData(album: String, artist: String) {
        
        guard let url = URL(string: "https://musicbrainz.org/ws/2/release/?query=release:\"\(album)\"AND artist:\"\(artist)\"&fmt=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "nil") else {
            print("Invalid URL")
            
            return
        }
        print(url)
        print("LoadData")
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(
                    MusicBrainzAPI.self, from: data)
                
                {
                    DispatchQueue.main.async {
                        self.searchMusicBrainzResults = decodedResponse.releases
                        self.ObtainAlbumItems()
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
    func ObtainAlbumItems() {
        
        guard let url = URL(string: "https://musicbrainz.org/ws/2/release/\(searchMusicBrainzResults[0].id)?inc=recordings&fmt=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "nil") else {
            print("Invalid URL")
            return
        }
        print(url)
        print("ObtainAlbumItems")
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(
                    SingleAlbum.self, from: data) {
                    DispatchQueue.main.async {
                        self.searchAlbumRecords = decodedResponse.media
                        print(self.searchAlbumRecords)
                        self.ObtainAlbumCoverUrl()
                    }
                    
                    
                    return
                }
                
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
    
    func ObtainAlbumCoverUrl() {
        print(RemoveSpacesAndPunch(str: searchMusicBrainzResults[0].title))
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(RemoveSpacesAndPunch(str: (searchMusicBrainzResults[0].title)))&attribute=albumTerm&entity=album") else {
            print("Invalid URL")
            
            return
        }
        
        print(url)
        print("ObtainAlbumCoverURL")
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(
                    AlbumCover.self, from: data)
                
                {
                    DispatchQueue.main.async {
                        self.albumCover = decodedResponse.results
                        print(self.albumCover)
            
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
    func RemoveSpacesAndPunch(str:  String) -> String {
        return str.replacingOccurrences(of: "([:punct:])", with: "", options: .regularExpression).replacingOccurrences(of: " ", with: "")
    }
    
    func AlbumCoverSearchBackup() -> String {
        return "hello"
    }
}

