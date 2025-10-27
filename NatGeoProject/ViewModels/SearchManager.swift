//
//  SearchManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import Foundation
import Observation

@Observable
class SearchManager {
    var searchResults: [TaxonSearchResult] = []
    private var searchTask: Task<Void, Never>?
    
    var speciesSearchField = "" {
        didSet {
            searchTask?.cancel()
            
            guard !speciesSearchField.isEmpty else {
                searchResults = []
                return
            }
            
            searchTask = Task {
                try? await Task.sleep(for: .milliseconds(500))
                
                guard !Task.isCancelled else { return }
                
                await performSearch()
            }
        }
    }
    
    private func performSearch() async {
        do {
            let results = try await searchTaxa(query: speciesSearchField)
            searchResults = results
        } catch {
            print("Error fetching taxa: \(error)")
            searchResults = []
        }
    }
    
    private func searchTaxa(query: String) async throws -> [TaxonSearchResult] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.inaturalist.org/v1/search?q=\(encodedQuery)&sources=taxa")
        else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        
        let filtered = decoded.results.compactMap { result -> TaxonSearchResult? in
            guard result.type == "Taxon",
                  let record = result.record,
                  record.rank != "hybrid"
            else { return nil }
            
            return TaxonSearchResult(
                taxon_id: record.id,
                common_name: record.preferred_common_name,
                scientific_name: record.name,
                image: record.default_photo?.medium_url
            )
        }
        
        return filtered
    }
}
