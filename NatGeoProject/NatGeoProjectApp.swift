//
//  NatGeoProjectApp.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

@main
struct NatGeoProjectApp: App {
    @State var manageLocation = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(manageLocation: manageLocation)
                .environment(ViewsManager())
        }
    }
}
