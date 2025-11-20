//
//  SearchView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

enum NewSearchScope: String, CaseIterable {
    case species = "by Species"
    case locations = "by Locations"
    case nl = "using AI"
}

struct SearchView: View {
    @Environment(ViewsManager.self) var viewManager
    @Bindable var searchManager: SearchManager
    
    @State private var selectedScope: NewSearchScope = .species
    
    var body: some View {
        NavigationStack {
            if searchManager.speciesSearchField.isEmpty {
                ContentUnavailableView.search
            } else {
                searchContent
            }
        }
        .searchable(
            text: $searchManager.speciesSearchField,
            prompt: "Start typing"
        )
        .searchScopes($selectedScope, activation: .onSearchPresentation) {
            ForEach(NewSearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue).tag(scope)
            }
        }
        .onAppear {
            viewManager.displayTabViewBottomAccessory = false
        }
    }
    
    @ViewBuilder
    var searchContent: some View {
        switch selectedScope {
        case .species:
            Text("Searching **\(searchManager.speciesSearchField)** for **Species**")
        case .locations:
            Text("Searching **\(searchManager.speciesSearchField)** for **Locations**")
        case .nl:
            Text("Searching for **\(searchManager.speciesSearchField)** using **Artificial Intelligence**")
        }
    }
}

#Preview {
    SearchView(searchManager: SearchManager())
        .environment(ViewsManager())
}
