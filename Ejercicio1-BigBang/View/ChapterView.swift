//
//  ChapterView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 9/11/21.
//

import SwiftUI

struct ChapterView: View {
    let chapter: BigBang
    
    var body: some View {
        HStack(alignment: .top) {
            Image(chapter.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("**Name:** \(chapter.name)")
                    .font(.subheadline)
                Text("**Season:** \(chapter.season)")
                    .font(.footnote)
                Text("**Airdate:** \(chapter.airdate)")
                    .font(.footnote)
            }
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(chapter: PersistenceModel.testChapter)
    }
}
