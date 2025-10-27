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
    var manageLocation: LocationManager
    
    var body: some View {
        tabs
            .tabBarMinimizeBehavior(.onScrollDown)
            .tabViewBottomAccessory {
                if viewManager.displayTabViewBottomAccessory {
                    UserLocationView(manageLocation: manageLocation)
                }
            }
    }
    
    var tabs: some View {
        TabView {
            ForEach(viewManager.Tabs, id: \.label) { tab in
                Tab(tab.label, systemImage: tab.icon) {
                    tab.view
                        .environment(viewManager)
                }
            }
            
            Tab(role: .search) {
                SearchView(searchManager: $searchManager)
                    .environment(viewManager)
            }
        }
    }
}

#Preview {
    MainAppView(manageLocation: LocationManager())
        .environment(ViewsManager())
}
