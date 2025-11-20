//
//  NewsListView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/19/25.
//

import SwiftUI

struct NewsListView: View {
    let newsArticles: [NewsArticle]
    let pageTitle: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(pageTitle)
                .font(.title2.bold())
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(newsArticles, id: \.self) { news in
                        NavigationLink{
                            Text(news.title)
                        } label: {
                            NewsView(news: news)
                                .frame(width: 280, height: 200)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
