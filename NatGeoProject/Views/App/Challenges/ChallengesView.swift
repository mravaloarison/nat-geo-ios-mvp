//
//  ChallengesView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ChallengesView: View {
    @Environment(ViewsManager.self) var viewManager
    @Bindable var quizzesManager: QuizzesManager
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 16)]
    
    @State var startedQuiz: Bool = false
    @State var selectedQuizIndex: Int? = nil

    var body: some View {
        VStack {
            HeaderLayout(tab: "Quizzes")
                .padding(.horizontal)
            content
            Spacer()
        }
        .fullScreenCover(isPresented: $startedQuiz) {
            QuizView(
                quiz: $quizzesManager.quizzes[selectedQuizIndex ?? 0],
                index: 0,
                isQuizEnding: $startedQuiz
            )
        }
        .onAppear {
            viewManager.displayTabViewBottomAccessory = false
        }
    }
    
    var content: some View {
        Group {
            if quizzesManager.isGeneratingQuizzes {
                ProgressView()
            } else if quizzesManager.error != nil{
                Text(quizzesManager.error ?? "Something went wrong while trying to get quizzes")
            } else {
                quizzes
                    .padding(.horizontal)
            }
        }
    }
    
    var quizzes: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(Array(quizzesManager.quizzes.enumerated()), id: \.offset) { index, quiz in
                    Button {
                        selectedQuizIndex = index
                        startedQuiz = true
                    } label: {
                        QuizzCardView(quiz: quiz)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
}

#Preview {
    ChallengesView(quizzesManager: QuizzesManager())
        .environment(ViewsManager())
}
