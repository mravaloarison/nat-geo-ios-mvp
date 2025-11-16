//
//  SearchView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(ViewsManager.self) var viewManager
    @Binding var searchManager: SearchManager
    
    var body: some View {
        NavigationStack {
            listOfResults
                .listStyle(.inset)
                .searchable(
                    text: $searchManager.speciesSearchField,
                    prompt: "Look for species"
                )
            
                .searchScopes($searchManager.searchScope, activation: .onSearchPresentation) {
                    Text("Normal Search")
                        .tag(SearchScope.naturalLanguage)
                        .padding()
                    Text("Use Natural Language")
                        .tag(SearchScope.naturalLanguage)
                        .padding()
                }
        }
        .onAppear {
            viewManager.displayTabViewBottomAccessory = false
        }
    }
    
    var listOfResults: some View {
        Group {
            if searchManager.isSearching {
                ProgressView()
            } else if searchManager.searchResults.count == 0 {
                Text("No result.")
            } else {
                List(0..<searchManager.searchResults.count, id: \.self) { index in
                    NavigationLink {
                        Text("Itme \(index + 1)")
                    } label: {
                        ResultListView(taxon: searchManager.searchResults[index])
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(searchManager: .constant(SearchManager()))
        .environment(ViewsManager())
}
