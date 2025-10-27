//
//  AIView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct AIView: View {
    @Environment(ViewsManager.self) var viewManager

    var body: some View {
        Text("AI View")
            .onAppear {
                viewManager.displayTabViewBottomAccessory = false
            }
    }
}

#Preview {
    AIView()
        .environment(ViewsManager())
}
