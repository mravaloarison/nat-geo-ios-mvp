//
//  NewsView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/19/25.
//

import SwiftUI

struct NewsView: View {
    let news: NewsArticle
    
    var body: some View {
        AsyncImage(url: URL(string: news.urlToImage)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .overlay(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text(news.source.name)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(3)
                Text(news.title)
                    .font(.title3.bold())
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NewsView(news: NewsArticle(
        publishedAt: "2021-02-17T14:37:24.3386254Z",
        source: Source(id: "", name: "National Geographic"),
        title: "3-ton parts of Stonehenge may have been carried from earlier monuments",
        url: "https://www.nationalgeographic.com/history/2021/02/3-ton-parts-stonehenge-may-carried-from-earlier-monuments.html",
        urlToImage: "https://images.seattletimes.com/wp-content/uploads/2025/11/11182025_weather111825-tzr_tzr_063025.jpg?d=1200x630")
    )
    .frame(width: 280, height: 200)
}
