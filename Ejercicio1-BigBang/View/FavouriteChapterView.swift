//
//  FavouriteChapterView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 9/11/21.
//

import SwiftUI

struct FavouriteChapterView: View {
    let chapter: BigBang
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .cornerRadius(10)
            VStack(alignment: .center) {
                ZStack(alignment: .topTrailing) {
                    Image(chapter.image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 100)
                        .padding(.top)
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 40, height: 20)
                            .cornerRadius(5)
                            .padding(.trailing, -8)
                        Text("S \(chapter.season)")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .bold()
                    }
                }
                
                Text(chapter.name)
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .padding(.bottom)
            }
        }
        .frame(minHeight: 150)
    }
}

struct FavouriteChapterView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteChapterView(chapter: PersistenceModel.testChapter)
    }
}
