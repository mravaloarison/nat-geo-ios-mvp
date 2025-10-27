//
//  HomeView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewsManager.self) var viewManager

    var body: some View {
        Text("Home View")
            .onAppear {
                viewManager.displayTabViewBottomAccessory = false
            }
    }
}

#Preview {
    HomeView()
        .environment(ViewsManager())
}
