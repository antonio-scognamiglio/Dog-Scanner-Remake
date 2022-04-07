//
//  DogCollection.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 15/12/21.
//

import Foundation

class DogStore: ObservableObject {
    @Published var dogs: [Dog] = load("Dogs.json")
// con questo load ho caricato nel mio array di cani tutti gli elementi che ho messo nel file json
    /// Decode JSON from the app bundle
    /// This func stops app execution if reading from the file fails, or if the data read is corrupted or otherwise invalid.
    /// - Returns: A value of the requested type
    static func load<T: Decodable>(_ filename: String) -> T {
        guard
            let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
//    func checkDog (nomeCane: String, arrayCani: [Dog]) -> Bool {
//        for dog in arrayCani {
//            if arrayCani.dogs[dog].name
//        }
//    }
}
