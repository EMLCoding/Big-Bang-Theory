//
//  ChapterDetailView.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 9/11/21.
//

import SwiftUI

struct ChapterDetailView: View {
    @EnvironmentObject var chapterVM: ChaptersViewModel
    @ObservedObject var chapterDetailVM:ChapterDetailVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            ZStack(alignment: .bottomTrailing) {
                Image(chapterDetailVM.chapter.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
                HStack {
                    Image(systemName: chapterVM.isViewed(chapter: chapterDetailVM.chapter) ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Rectangle()
                                        .fill(chapterVM.isViewed(chapter: chapterDetailVM.chapter) ? Color.green : Color.red)
                                        .cornerRadius(10)
                                        .frame(width: 50, height: 50)
                        )
                        .onTapGesture {
                            chapterVM.toggleViewed(chapter: chapterDetailVM.chapter)
                        }
                    
                    Image(systemName: chapterVM.isFavourite(chapter: chapterDetailVM.chapter) ? "star.fill" : "star.slash.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Rectangle()
                                        .fill(chapterVM.isFavourite(chapter: chapterDetailVM.chapter) ? Color.yellow : Color.red)
                                        .cornerRadius(10)
                                        .frame(width: 50, height: 50)
                        )
                        .onTapGesture {
                            chapterVM.toggleFavourite(chapter: chapterDetailVM.chapter)
                        }
                }
                .padding(5)
            }
            
            Section {
                Text("**Chapter's name:** \(chapterDetailVM.chapter.name)")
                Text("**Airdate:** \(chapterDetailVM.chapter.airdate)")
                Text("**Duration:** \(chapterDetailVM.chapter.runtime) min")
                Link(destination: chapterDetailVM.chapter.url) {
                    Label("See more info", systemImage: "safari")
                }
            } header: {
                Text("Chapter's detail")
            }
            Section {
                TextEditor(text: $chapterDetailVM.notes)
                HStack {
                    ForEach(1..<6) { i in
                        Image(systemName: chapterDetailVM.score >= i ? "star.fill" : "star")
                            .foregroundColor(chapterDetailVM.score >= i ? .yellow : .primary)
                            .onTapGesture {
                                chapterDetailVM.score = i
                            }
                    }
                }
            } header: {
                Text("User's information")
            }
            
        }
        .navigationTitle("Chapter's information")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    chapterVM.uploadUserInformationAbout(chapter: chapterDetailVM.saveInformation(chapter: chapterDetailVM.chapter))
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        
    }
}

struct ChapterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterDetailView(chapterDetailVM: ChapterDetailVM(chapter: PersistenceModel.testChapter))
    }
}
