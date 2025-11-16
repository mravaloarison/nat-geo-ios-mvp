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
    var searchScope: SearchScope = .iNaturalist
    var isSearching = false
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
        switch searchScope {
        case .iNaturalist:
            do {
                let results = try await searchTaxa(query: speciesSearchField)
                searchResults = results
            } catch {
                print("Error fetching taxa: \(error)")
                searchResults = []
            }
        case .naturalLanguage:
            do { print("hi") }
        }
    }
    
    func searchTaxa(query: String) async throws -> [TaxonSearchResult] {
        isSearching = true
        defer { isSearching = false }

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
    
    func naturalLanguageSearch(query: String) async throws -> [TaxonSearchResult] {
        isSearching = true
        defer { isSearching = false }
                
        var urlString: String { "http://127.0.0.1:5000/perform_natural_language_search" }
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from: \(urlString)")
            return []
        }
        
        do {
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
            
        } catch {
            print("Error generating fun facts:", error)
            return []
        }
    }
}
