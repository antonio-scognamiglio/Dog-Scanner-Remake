//
//  Dog.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 15/12/21.
//

import Foundation

//credo che decodable sia obbligatorio per via del file json

struct Dog: Identifiable, Decodable {
    let id: Int
    let name: String
    let wallpaper: String
    let icon: String
    
}
