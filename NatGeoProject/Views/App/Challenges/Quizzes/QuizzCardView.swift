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
                .frame(width: geometry.size.width)
                .clipped()
                .cornerRadius(12)
                Text(quiz.speciesName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .padding(.horizontal, 4)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
//        .aspectRatio(1 / (imageAspectRatio + 0.5), contentMode: .fit)
    }
}

#Preview {
    QuizzCardView(quiz: Quizzes(
        speciesName: "Giant Panda",
        imageUrl: "https://inaturalist-open-data.s3.amazonaws.com/photos/150277588/medium.jpg",
        generatedQuizzes: [
            GeneratedQuizz(
                question: "What is the primary diet of a Giant Panda?",
                arrayOfChoices: [
                    .init(choice: "Bamboo", isCorrect: true),
                    .init(choice: "Fish", isCorrect: false),
                    .init(choice: "Small Mammals", isCorrect: false),
                    .init(choice: "Berries", isCorrect: false)
                ],
                nextQuestion: 1
            )
        ]
    ))
}
