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
            icon: "puzzlepiece.extension",
            label: "Quizzes",
            view: AnyView(ChallengesView(quizzesManager: QuizzesManager()))
        )
    ]
    
    var displayTabViewBottomAccessory = false
    var showListOfObservationsView = false
    var showFiltersView = false
}
