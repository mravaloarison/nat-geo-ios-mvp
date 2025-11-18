//
//  QuizzCardView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/17/25.
//

import SwiftUI

struct QuizzCardView: View {
    let quiz: Quizzes
    let imageAspectRatio: CGFloat = 4 / 3
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 4) {
                img
                    .frame(width: geometry.size.width)
                    .clipped()
                    .cornerRadius(12)
                speciesName
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
    }
    
    var img: some View {
        AsyncImage(url: URL(string: quiz.imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(imageAspectRatio, contentMode: .fit)
            } else if phase.error != nil {
                Color.red.opacity(0.2)
                    .aspectRatio(imageAspectRatio, contentMode: .fit)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(imageAspectRatio, contentMode: .fit)
            }
        }
    }
    
    var speciesName: some View {
        Text(quiz.speciesName)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .lineLimit(1)
            .padding(.horizontal, 4)
    }
}
