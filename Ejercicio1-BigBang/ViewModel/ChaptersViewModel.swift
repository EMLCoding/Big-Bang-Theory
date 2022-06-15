//
//  ChaptersVM.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import Foundation

final class ChaptersViewModel: ObservableObject {
    
    @Published var seasons: [Season] = []
    @Published var chapters: [BigBang] = [] {
        didSet {
            if !chapters.isEmpty {
                PersistenceModel.saveModel(filename: "BigBang", data: chapters)
            }
        }
    }
    
    @Published var seasonSelected = 1
    @Published var searchText = ""
    
    var chaptersFavourites: [BigBang] {
        chapters.filter {
            isFavourite(chapter: $0)
        }
    }
    
    var chaptersFiltered: [BigBang] {
        if searchText.isEmpty {
            if (seasonSelected != -1) {
                return chapters.filter {
                    $0.season == seasonSelected
                }
            } else {
                return chapters
            }
        } else {
            if (seasonSelected != -1) {
                return chapters.filter {
                    $0.season == seasonSelected && $0.name.lowercased().contains(searchText.lowercased())
                }
            } else {
                return chapters.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    init() {
        chapters = PersistenceModel.loadModel(filename: "BigBang", type: BigBang.self)
        seasons = loadSeasons(chapters: chapters)
    }
    
    func loadSeasons(chapters: [BigBang]) -> [Season] {
        var seasonNumber = 0
        var seasons: [Season] = []
        chapters.forEach { chapter in
            if seasonNumber != chapter.season {
                let season = Season(id: chapter.season, summary: chapter.summary, image: "season\(chapter.season)", chapters: [])
                seasons.append(season)
                seasonNumber += 1
            }
        }
        return seasons
    }
    
    func selected(season: Int) {
        if season == seasonSelected {
            seasonSelected = -1
        } else {
            seasonSelected = season
        }
    }
    
    func isFavourite(chapter: BigBang) -> Bool {
        if let favourite = chapter.favourite {
            return favourite
        } else {
            return false
        }
    }
    
    func toggleFavourite(chapter: BigBang) {
        if let index = chapters.firstIndex(where: { $0.id == chapter.id }) {
            if let favourite = chapters[index].favourite {
                print(chapters[index])
                chapters[index].favourite = !favourite
            } else {
                chapters[index].favourite = true
            }
        }
    }
    
    func toggleFavourite(season: Int) {
        let chaptersSeason = chapters.filter {
            $0.season == season
        }
        for chapter in chaptersSeason {
            if let index = chapters.firstIndex(where: { $0.id == chapter.id }) {
                chapters[index].favourite = true
            }
        }
    }
    
    func isViewed(chapter: BigBang) -> Bool {
        if let viewed = chapter.viewed {
            return viewed
        } else {
            return false
        }
    }
    
    func toggleViewed(chapter: BigBang) {
        if let index = chapters.firstIndex(where: { $0.id == chapter.id }) {
            if let viewed = chapters[index].viewed {
                chapters[index].viewed = !viewed
            } else {
                chapters[index].viewed = true
            }
        }
    }
    
    func uploadUserInformationAbout(chapter: BigBang) {
        if let index = chapters.firstIndex(where: { $0.id == chapter.id }) {
            chapters[index] = chapter
        }
    }
    
}
