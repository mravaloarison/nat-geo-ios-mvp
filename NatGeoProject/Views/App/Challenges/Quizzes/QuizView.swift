//
//  QuizView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/18/25.
//

import SwiftUI

struct QuizView: View {
    @Binding var quiz: Quizzes
    var index: Int?
    
    @Binding var isQuizEnding: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                question
                QuizChoicesList(quiz: $quiz.generatedQuizzes, index: index)
                Spacer()
                navBtn
            }
            .toolbar {
                ToolbarItem {
                    Button("Close", systemImage: "xmark", role: .cancel) {
                        isQuizEnding = false
                    }
                }
            }
        }
    }
    
    var question: some View {
        Text(quiz.generatedQuizzes[index ?? 0].question)
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var navBtn: some View {
        Group {
            if index == quiz.generatedQuizzes.count - 1 {
                userIsDoneBtn
            } else {
                nextQuizBtn
                    .buttonStyle(.plain)
            }
        }
        .padding()
    }
    
    var userIsDoneBtn: some View {
        Button("Done") {
            isQuizEnding = false
        }
        .frame(maxWidth: .infinity)
        .padding()
        .font(.headline)
        .glassEffect()
    }
    
    var nextQuizBtn: some View {
        NavigationLink {
            QuizView(
                quiz: $quiz,
                index: quiz.generatedQuizzes[index ?? 0].nextQuestion,
                isQuizEnding: $isQuizEnding
            )
        } label: {
            HStack {
                Spacer()
                Image(systemName: "arrow.forward")
                    .padding()
                    .glassEffect(.regular.tint(.blue))
            }
        }
    }
}
