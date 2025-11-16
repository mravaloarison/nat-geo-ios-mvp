//
//  HomeView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewsManager.self) var viewManager
    @Environment(AIManager.self) var geminiManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HeaderLayout(tab: "Home")
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        todaystar
                        funfacts
                    }
                }
            }
            .onAppear {
                viewManager.displayTabViewBottomAccessory = false
            }
        }
    }
    
    var todaystar: some View {
        TodaysSuperstarView(funFact: FunFact(
            specie: "Octopus",
            fact: "Octopuses have three hearts and blue blood, making them one of the ocean's most fascinating creatures.",
            image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg")
        )
    }
    
    var funfacts: some View {
        Group {
            if geminiManager.isGenerating {
                ProgressView()
            } else {
                LazyVStack(alignment: .leading, spacing: Constants.standardPadding) {
                    FunFactHorizontalListView(funfacts: geminiManager.FunFacts)
                        .frame(height: 260.0)
//                    FunFactHorizontalListView(funfacts: [
//                        FunFact(
//                            specie: "Octopus",
//                            fact: "Lençóis Maranhenses National Park covers approximately 380,000 acres on the northeastern coast of Brazil.",
//                            image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg"
//                        ),
//                        FunFact(
//                            specie: "Blue Whale",
//                            fact: "The blue whale's heart can weigh as much as a car and beats only 5-6 times per minute when diving.",
//                            image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg"
//                        )
//                    ])
//                    .frame(height: 260.0)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(ViewsManager())
        .environment(AIManager())
}
