//
//  QuizChoicesList.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/18/25.
//

import SwiftUI

struct QuizChoicesList: View {
    @Binding var quiz: [GeneratedQuizz]
    var index: Int?
    
    var body: some View {
        VStack(spacing: 20) {
            if index == nil {
                EmptyView()
            } else {
                ForEach(quiz[index ?? 0].arrayOfChoices.indices, id: \.self) { id in
                    QuizChoicesBtn (
                        choice: quiz[index ?? 0].arrayOfChoices[id].choice,
                        isSelected: index != nil && quiz[index ?? 0].selected == id
                    ) {
                        quiz[index ?? 0].selected = id
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
