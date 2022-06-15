//
//  Chapter.swift
//  Ejercicio1-BigBang
//
//  Created by Eduardo Martin Lorenzo on 8/11/21.
//

import Foundation

struct BigBang: Codable, Identifiable {
    let id: Int
    let url: URL
    let name: String
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    var notes: String?
    var score: Int?
    var favourite: Bool?
    var viewed: Bool?
}

struct Season: Identifiable {
    let id: Int
    let summary: String
    let image: String
    var chapters: [BigBang]
}

struct PersistenceModel {
    static func loadModel<ModelType: Codable & Identifiable>(filename: String, type: ModelType.Type) -> [ModelType] {
        guard var url = Bundle.main.url(forResource: filename, withExtension: "json"), let urlDoc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        let fileURL = urlDoc.appendingPathComponent(filename).appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            url = fileURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([ModelType].self, from: data)
        } catch {
            print("Error en la carga de datos: \(error)")
            return []
        }
    }
    
    static func saveModel<ModelType: Codable>(filename: String, data: ModelType) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = url.appendingPathComponent(filename).appendingPathExtension("json")
        Task(priority: .background) {
            do {
                let json = try JSONEncoder().encode(data)
                try json.write(to: fileURL, options: [.atomic, .completeFileProtection])
            } catch {
                print("Error en el guardado de datos: \(error)")
            }
        }
    }
    
    static let testChapter = BigBang(id: 1, url: URL(string: "https://www.tvmaze.com/episodes/2913/the-big-bang-theory-1x01-pilot")!, name: "Pilot", season: 1, number: 1, airdate: "2007-09-24", runtime: 30, image: "12368", summary: "Is a comedy about brilliant physicists, Leonard and Sheldon, who are the kind of \"beautiful minds\" that understand how the universe works. But none of that genius helps them interact with people, especially women. All this begins to change when a free-spirited beauty named Penny moves in next door. Sheldon, Leonard's roommate, is quite content spending his nights playing Klingon Boggle with their socially dysfunctional friends, fellow Cal Tech scientists Wolowitz and Koothrappali. However, Leonard sees in Penny a whole new universe of possibilities... including love.\n", notes: "", score: 0, favourite: false, viewed: false)
}
