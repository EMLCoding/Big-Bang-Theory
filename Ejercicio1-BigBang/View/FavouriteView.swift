//
//  FavouriteView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var chaptersVM: ChaptersViewModel
    
    let columns:[GridItem] = .init(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                if chaptersVM.chaptersFavourites.count == 0 {
                    Text("Add chapters to your favourite list")
                        .bold()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(chaptersVM.chaptersFavourites) { chapter in
                            NavigationLink(destination: ChapterDetailView(chapterDetailVM: ChapterDetailVM(chapter: chapter))) {
                                FavouriteChapterView(chapter: chapter)
                                    .contextMenu {
                                        Button {
                                            withAnimation {
                                                chaptersVM.toggleFavourite(chapter: chapter)
                                            }
                                        } label: {
                                            Label("Unmark as favorite", systemImage: "star")
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favourite chapters")
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
