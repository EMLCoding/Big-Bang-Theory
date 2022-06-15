//
//  TabView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import SwiftUI

struct TabScreenView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Big Bang", systemImage: "tv")
                }
            FavouriteView()
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
        }
    }
}

struct TabScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
    }
}
