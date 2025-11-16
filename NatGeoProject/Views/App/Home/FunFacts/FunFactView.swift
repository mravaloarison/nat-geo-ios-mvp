//
//  FunFactView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/12/25.
//

import SwiftUI

struct FunFactView: View {
    let funFact: FunFact
    
    var body: some View {
        AsyncImage(url: URL(string: funFact.image_url)) { phase in
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
                Text(funFact.specie)
                    .font(.title3.bold())
                    .foregroundStyle(.white.opacity(0.9))
                Text(funFact.fact)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(3)
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
    FunFactView(funFact: FunFact(
        specie: "Octopus",
        fact: "Lençóis Maranhenses National Park covers approximately 380,000 acres on the northeastern coast of Brazil, including 43 miles of coastline along the Atlantic Ocean.",
        image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg")
    )
    .frame(width: 280, height: 200)
}
