//
//  ChallengesView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ChallengesView: View {
    @Environment(ViewsManager.self) var viewManager

    var body: some View {
        Text("Challenges View")
            .onAppear {
                viewManager.displayTabViewBottomAccessory = false
            }
    }
}

#Preview {
    ChallengesView()
        .environment(ViewsManager())
}
