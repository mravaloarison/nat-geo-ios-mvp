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
            HeaderLayout(tab: "Search")
                .padding(.horizontal)
            listOfResults
            .listStyle(.inset)
            .searchable(
                text: $searchManager.speciesSearchField,
                prompt: "Look for species"
            )
        }
        .onAppear {
            viewManager.displayTabViewBottomAccessory = true
        }
    }
    
    var listOfResults: some View {
        Group {
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

#Preview {
    SearchView(searchManager: .constant(SearchManager()))
        .environment(ViewsManager())
}
