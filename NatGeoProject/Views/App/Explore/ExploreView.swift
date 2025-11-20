//
//  ExploreView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ExploreView: View {
    @Environment(ViewsManager.self) var viewManager
    @Environment(LocationManager.self) var manageLocation
    var exploreManager: ExploreManager
    
    @State private var showListView = false
    @State private var showFiltersView = false

    var body: some View {
        if manageLocation.userLocation.isAuthorized {
            locationAuthorizedView
                .onAppear {
                    viewManager.displayTabViewBottomAccessory = true
                }
        } else {
            NoMapsView()
        }
    }
    
    var locationAuthorizedView: some View {
        NavigationStack {
            MapsView()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                       goToListOfObservationsBtn
                    }
                }
                .navigationDestination(isPresented: $showListView) {
                    ObservationListView(
                        showListView: $showListView,
                        showFiltersView: $showFiltersView
                    )
                    .environment(exploreManager)
                }
        }
    }
    
    var goToListOfObservationsBtn: some View {
        Button {
            showListView = true
        } label: {
            Image(systemName: "list.dash")
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    ExploreView(exploreManager: ExploreManager())
        .environment(ViewsManager())
        .environment(LocationManager())
}
