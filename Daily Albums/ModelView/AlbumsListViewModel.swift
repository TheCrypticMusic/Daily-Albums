//
//  AlbumViewModel.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 22/04/2021.
//

import SwiftUI

class AlbumsListViewModel: ObservableObject {
    
    @Published var details = [AlbumsItem]()
    init() {
        self.details = load("1001-albums.json")
        
        
        
        func load<T: Decodable>(_ filename: String) -> T {
            
            let data: Data
            
            
            guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            
            else {
                
                fatalError("Couldn't find \(filename) in main bundle.")
                
            }
            do {
                
                data = try Data(contentsOf: file)
                
            } catch {
                
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
                
            }
            
            
            do {
                
                let decoder = JSONDecoder()
                
                return try decoder.decode(T.self, from: data)
                
            } catch {
                
                fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
                
            }
        }
        
    }
}
