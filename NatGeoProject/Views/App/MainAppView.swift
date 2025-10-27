//
//  MainAppView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct MainAppView: View {
    @Environment(ViewsManager.self) var viewManager
    
    var body: some View {
        tabs
            .tabBarMinimizeBehavior(.onScrollDown)
            .tabViewBottomAccessory {
                if viewManager.displayTabViewBottomAccessory {
                    UserLocationView()
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
                SearchView()
                    .environment(viewManager)
            }
        }
    }
}

#Preview {
    MainAppView()
        .environment(ViewsManager())
}
