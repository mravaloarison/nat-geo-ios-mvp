//
//  ChallengesView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ChallengesView: View {
//    @Environment(ViewsManager.self) var viewManager
    var quizzesManager: QuizzesManager
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 16)]

    var body: some View {
        NavigationStack {
            HeaderLayout(tab: "Quizzes")
                .padding(.horizontal)
            Group {
                if quizzesManager.isGeneratingQuizzes {
                    ProgressView()
                } else if quizzesManager.error != nil{
                    Text(quizzesManager.error ?? "Something went wrong while trying to get quizzes")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(quizzesManager.quizzes, id:\.self) { quizz in
                                QuizzCardView(quiz: quizz)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
//        .onAppear {
//            viewManager.displayTabViewBottomAccessory = false
//        }
    }
}

#Preview {
    ChallengesView(quizzesManager: QuizzesManager())
//        .environment(ViewsManager())
}
