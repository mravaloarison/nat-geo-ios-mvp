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

    var body: some View {
        NavigationStack {
            HeaderLayout(tab: "Quizzes")
            VStack {
                if quizzesManager.isGeneratingQuizzes {
                    ProgressView()
                } else if quizzesManager.error != nil{
                    Text(quizzesManager.error ?? "Something went wrong while trying to get quizzes")
                } else {
                    Group {
                        Text("generated:")
                        ForEach(quizzesManager.quizzes, id:\.self) { quizz in
                            Text(quizz.speciesName)
                        }
                    }
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
