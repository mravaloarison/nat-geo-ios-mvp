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
    
    var newsManager: NewsManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HeaderLayout(tab: "Home")
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        funfacts
                        latestNews
                    }
                }
            }
            .onAppear {
                viewManager.displayTabViewBottomAccessory = false
            }
        }
    }
    
    var funfacts: some View {
        Group {
            if geminiManager.isGenerating {
                ProgressView()
            } else {
                LazyVStack(
                    alignment: .leading,
                    spacing: Constants.standardPadding) {
                    FunFactHorizontalListView(funfacts: geminiManager.FunFacts)
                        .frame(height: 260.0)
                }
            }
        }
    }
    
    var latestNews: some View {
        Group {
            if newsManager.isGeneratingNews {
                ProgressView()
            } else {
                LazyVStack(
                    alignment: .leading,
                    spacing: Constants.standardPadding
                )  {
                    NewsListView(
                        newsArticles: newsManager.scienceNews,
                        pageTitle: "Science News"
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView(newsManager: NewsManager())
        .environment(ViewsManager())
        .environment(AIManager())
}
