//
//  GeminiModelData.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/12/25.
//

import Foundation

struct FunFact: Codable, Hashable, Identifiable {
    let specie: String
    let fact: String
    var image_url: String
    
    var id: String { specie }
    
    enum CodingKeys: String, CodingKey {
        case specie
        case fact
        case image_url
    }
    
    init(specie: String, fact: String, image_url: String) {
        self.specie = specie
        self.fact = fact
        self.image_url = image_url
    }
}

struct FunFactResponse: Codable {
    let fun_facts: [FunFact]
}
