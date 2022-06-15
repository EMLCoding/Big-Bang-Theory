//
//  SeasonView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import SwiftUI

struct SeasonView: View {
    @EnvironmentObject var chaptersVM: ChaptersViewModel
    
    let season: Season
    
    var body: some View {
        Image(season.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: 150)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: season.id == chaptersVM.seasonSelected ? 1 : 0))
            .shadow(color: .black.opacity(season.id == chaptersVM.seasonSelected ? 0.0 : 0.5), radius: 2, x: 3, y: 3)

            
    }
}

struct SeasonView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonView(season: Season(id: 1, summary: "Resumen", image: "season1", chapters: []))
    }
}
