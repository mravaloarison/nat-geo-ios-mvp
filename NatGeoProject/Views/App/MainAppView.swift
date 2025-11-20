//
//  MainAppView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct MainAppView: View {
    @Environment(ViewsManager.self) var viewManager
    @State var searchManager = SearchManager()
    @State var geminiManager = AIManager()
    var manageLocation: LocationManager
    
    var body: some View {
        tabs
            .tabBarMinimizeBehavior(.onScrollDown)
            .task {
                if geminiManager.FunFacts.count > 0 {
                    print("Fun fact already filled")
                } else {
                    do {
                        try await geminiManager.generateFunFact()
                    } catch {
                        print("Gemini failed: \(error)")
                    }
                }
            }
    }
    
    var tabs: some View {
        TabView {
            ForEach(viewManager.Tabs, id: \.label) { tab in
                Tab(tab.label, systemImage: tab.icon) {
                    tab.view
                        .environment(viewManager)
                        .environment(manageLocation)
                        .environment(geminiManager)
                }
            }
            
            Tab(role: .search) {
                SearchView(searchManager: searchManager)
                    .environment(viewManager)
            }
        }
    }
}

#Preview {
    MainAppView(manageLocation: LocationManager())
        .environment(ViewsManager())
}
