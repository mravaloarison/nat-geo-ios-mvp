//
//  SearchView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(ViewsManager.self) var viewManager

    var body: some View {
        Text("Search View")
            .onAppear {
                viewManager.displayTabViewBottomAccessory = true
            }
    }
}

#Preview {
    SearchView()
        .environment(ViewsManager())
}
