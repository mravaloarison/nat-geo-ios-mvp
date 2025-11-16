//
//  AIManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/12/25.
//

import Foundation
import Observation

@MainActor
@Observable class AIManager {
    var isGenerating = false
    var FunFacts: [FunFact] = []
    
    private let findSpecies = SearchManager()
    
    var urlString: String { "http://127.0.0.1:5000/fun-facts" }
    
    func generateFunFact() async throws {
        isGenerating = true
        defer { isGenerating = false }
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from: \(urlString)")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Server error: \(response)")
                return
            }
            
            let decodedResponse = try JSONDecoder().decode([FunFact].self, from: data)
                        
            self.FunFacts = decodedResponse
            
            print("Everything went right, generated: \(FunFacts.count) fun facts")
            
        } catch {
            print("Error generating fun facts:", error)
        }
        
    }
}
