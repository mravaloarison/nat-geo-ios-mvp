//
//  FavoritesView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(ViewsManager.self) var viewManager

    var body: some View {
        NavigationStack {
            VStack {
                HeaderLayout(tab: "Favorites")
                    .padding(.horizontal)
                Spacer()
            }
        }
        .onAppear {
            viewManager.displayTabViewBottomAccessory = false
        }
    }
}

#Preview {
    FavoritesView()
        .environment(ViewsManager())
}
