//
//  AlbumCoverView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 29/04/2021.
//

import SwiftUI

struct AlbumCoverView: View {
    
    
    
    var url: String
    var placeholder: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }
    
    var body: some View {
        VStack {
            
            if let data = self.imageLoader.downloadedData {
                Image(uiImage: UIImage(data: data)!)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                
            } else {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                    .padding(.bottom)
             
                
                
                
            }
        }.padding()
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct AlbumCoverView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCoverView(url: "https://is3-ssl.mzstatic.com/image/thumb/Music128/v4/26/9f/8c/269f8c5d-74a9-fb43-1e61-0c05af16148a/source/100x100bb.jpg", placeholder: "placeholder")
    }
}
