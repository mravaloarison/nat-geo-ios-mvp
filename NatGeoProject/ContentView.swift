//
//  ContentView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewsManager.self) var viewsManager
    
    var body: some View {
        MainAppView()
            .environment(viewsManager)
    }
}

#Preview {
    ContentView()
        .environment(ViewsManager())
}
