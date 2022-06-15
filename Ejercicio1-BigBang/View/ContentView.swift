//
//  ContentView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var chaptersVM: ChaptersViewModel
    
    var body: some View {
            NavigationView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(chaptersVM.seasons) { season in
                                SeasonView(season: season)
                                    .contextMenu {
                                        Button {
                                            withAnimation {
                                                chaptersVM.toggleFavourite(season: season.id)
                                            }
                                        } label: {
                                            Label("Mark all season as favourite", systemImage: "star")
                                        }
                                    }
                                    .onTapGesture {
                                        chaptersVM.selected(season: season.id)
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 100)
                    
                    List {
                        HStack {
                            TextField("Search", text: $chaptersVM.searchText)
                            Button {
                                chaptersVM.searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .opacity(chaptersVM.searchText.isEmpty ? 0.0 : 0.3)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.gray.opacity(0.1))
                        }
                        .padding(10)
                        
                        ForEach(chaptersVM.chaptersFiltered) { chapter in
                            NavigationLink(destination: ChapterDetailView(chapterDetailVM: ChapterDetailVM(chapter: chapter))) {
                                ChapterView(chapter: chapter)
                            }
                            .swipeActions {
                                Button {
                                    chaptersVM.toggleFavourite(chapter: chapter)
                                } label: {
                                    Label("Favourite", systemImage: (chapter.favourite ?? false) ? "star.slash" : "star")
                                }
                                .tint(chaptersVM.isFavourite(chapter: chapter) ? .red : .yellow)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    chaptersVM.toggleViewed(chapter: chapter)
                                } label: {
                                    Label("Viewed", systemImage: (chapter.viewed ?? false) ? "eye.slash" : "eye")
                                }
                                .tint(chaptersVM.isViewed(chapter: chapter) ? .red : .green)
                            }
                        }
                    }
                    
                }
                .navigationTitle("The Big Bang Theory")
            }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChaptersViewModel())
    }
}
