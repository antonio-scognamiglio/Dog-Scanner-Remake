//
//  DogCollection.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 15/12/21.
//

import Foundation

class DogStore: ObservableObject {
    @Published var dogs: [Dog] = load("Dogs.json")

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
    
}
