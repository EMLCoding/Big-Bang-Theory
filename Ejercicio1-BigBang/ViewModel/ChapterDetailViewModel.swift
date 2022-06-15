//
//  ChapterDetailViewModel.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 9/11/21.
//

import Foundation

final class ChapterDetailVM: ObservableObject {
    @Published var notes = ""
    @Published var score = 0
    
    let chapter: BigBang
    
    init(chapter: BigBang) {
        self.chapter = chapter
        notes = chapter.notes ?? ""
        score = chapter.score ?? 0
    }
    
    func saveInformation(chapter: BigBang) -> BigBang {
        return BigBang(id: chapter.id,
                       url: chapter.url,
                       name: chapter.name,
                       season: chapter.season,
                       number: chapter.number,
                       airdate: chapter.airdate,
                       runtime: chapter.runtime,
                       image: chapter.image,
                       summary: chapter.summary,
                       notes: notes,
                       score: score,
                       favourite: chapter.favourite,
                       viewed: chapter.viewed)
    }
}
