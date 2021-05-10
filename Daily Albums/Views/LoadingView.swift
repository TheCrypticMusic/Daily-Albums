//
//  LoadingView.swift
//  Daily Albums
//
//  Created by Daniel Gibson on 03/05/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {

            VStack{
                ProgressView("Loading Album Cover...")
            }

        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
