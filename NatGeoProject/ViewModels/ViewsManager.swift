//
//  ViewsManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
import Foundation

@Observable class ViewsManager {
    var Tabs: [TabItem] = [
        TabItem(
            icon: "house",
            label: "Home",
            view: AnyView(HomeView())
        ),
        TabItem(
            icon: "rectangle.and.text.magnifyingglass",
            label: "Explore",
            view: AnyView(ExploreView())
        ),
        TabItem(
            icon: "sparkles.2",
            label: "AI Guide",
            view: AnyView(AIView())
        ),
        TabItem(
            icon: "puzzlepiece.extension",
            label: " Challenges",
            view: AnyView(ChallengesView())
        )
    ]
    
    var displayTabViewBottomAccessory: Bool = false
}
