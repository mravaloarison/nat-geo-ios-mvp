//
//  TodaysSuperstarView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/14/25.
//

import SwiftUI

struct TodaysSuperstarView: View {
    let funFact: FunFact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Superstar")
                .font(.title2.bold())
                .padding(.horizontal)
            
            NavigationLink {
                Text("Today's SuperStar")
            } label: {
                AsyncImage(url: URL(string: funFact.image_url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Color.gray.opacity(0.2)
                    }
                }
                .frame(width: 280, height: 360)
                .frame(maxWidth: .infinity)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(funFact.specie.uppercased())
                            .font(.caption.bold())
                            .foregroundStyle(.white.opacity(0.8))
                        
                        Text(funFact.fact)
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .lineLimit(3)
                        
                        HStack(spacing: 4) {
                            Text("Read more about \(funFact.specie)")
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                            Image(systemName: "chevron.right")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 4)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    TodaysSuperstarView(funFact: FunFact(
        specie: "Octopus",
        fact: "Octopuses have three hearts and blue blood, making them one of the ocean's most fascinating creatures.",
        image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg")
    )
}
