//
//  Ejercicio1_BigBangApp.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import SwiftUI

@main
struct Ejercicio1_BigBangApp: App {
    @StateObject var chaptersVM = ChaptersViewModel()
    var body: some Scene {
        WindowGroup {
            TabScreenView()
                .environmentObject(chaptersVM)
        }
    }
}
