//
//  ContentView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewsManager.self) var viewsManager
    var manageLocation: LocationManager
    
    var body: some View {
        MainAppView(manageLocation: manageLocation)
            .environment(viewsManager)
            .onAppear {
                if !manageLocation.userLocation.isAuthorized {
                    manageLocation.startLocationServices()
                }
            }
    }
}

#Preview {
    ContentView(manageLocation: LocationManager())
        .environment(ViewsManager())
}
