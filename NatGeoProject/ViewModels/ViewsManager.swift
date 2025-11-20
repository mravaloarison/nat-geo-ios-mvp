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
            view: AnyView(HomeView(newsManager: NewsManager()))
        ),
        TabItem(
            icon: "rectangle.and.text.magnifyingglass",
            label: "Explore",
            view: AnyView(ExploreView(exploreManager: ExploreManager()))
        ),
        TabItem(
            icon: "heart",
            label: "Favorites",
            view: AnyView(FavoritesView())
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
