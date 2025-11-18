//
//  QuizzesManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/17/25.
//

import Foundation
import Observation

struct GeneratedChoice: Codable, Hashable {
    var choice: String
    var isCorrect: Bool
}

struct GeneratedQuizz: Codable, Hashable {
    var question: String
    var arrayOfChoices: [GeneratedChoice]
    var selected: Int? = nil
    var nextQuestion: Int? = nil
}

struct Quizzes: Codable, Hashable {
    var speciesName: String
    var imageUrl: String
    var generatedQuizzes: [GeneratedQuizz]
}

@MainActor
@Observable class QuizzesManager {
    var quizzes: [Quizzes] = [
        Quizzes(
            speciesName: "Giant Panda",
            imageUrl: "https://inaturalist-open-data.s3.amazonaws.com/photos/150277588/medium.jpg",
            generatedQuizzes: [
                GeneratedQuizz(
                    question: "What is the primary diet of a Giant Panda?",
                    arrayOfChoices: [
                        GeneratedChoice(choice: "Bamboo", isCorrect: true),
                        GeneratedChoice(choice: "Fish", isCorrect: false),
                        GeneratedChoice(choice: "Small Mammals", isCorrect: false),
                        GeneratedChoice(choice: "Berries", isCorrect: false)
                    ],
                    selected: nil,
                    nextQuestion: 1
                ),
                GeneratedQuizz(
                    question: "Where are Giant Pandas primarily found in the wild?",
                    arrayOfChoices: [
                        GeneratedChoice(choice: "Central China", isCorrect: true),
                        GeneratedChoice(choice: "Amazon Rainforest", isCorrect: false),
                        GeneratedChoice(choice: "African Savanna", isCorrect: false),
                        GeneratedChoice(choice: "Arctic Tundra", isCorrect: false)
                    ],
                    selected: nil,
                    nextQuestion: 2
                ),
                GeneratedQuizz(
                    question: "What is the conservation status of the Giant Panda?",
                    arrayOfChoices: [
                        GeneratedChoice(choice: "Vulnerable", isCorrect: true),
                        GeneratedChoice(choice: "Extinct", isCorrect: false),
                        GeneratedChoice(choice: "Least Concern", isCorrect: false),
                        GeneratedChoice(choice: "Critically Endangered", isCorrect: false)
                    ],
                    selected: nil,
                    nextQuestion: 3
                ),
                GeneratedQuizz(
                    question: "How often do female Giant Pandas typically reproduce?",
                    arrayOfChoices: [
                        GeneratedChoice(choice: "Every 2-3 years", isCorrect: true),
                        GeneratedChoice(choice: "Every year", isCorrect: false),
                        GeneratedChoice(choice: "Only once in their lifetime", isCorrect: false),
                        GeneratedChoice(choice: "Every 5-7 years", isCorrect: false)
                    ],
                    selected: nil,
                    nextQuestion: 4
                ),
                GeneratedQuizz(
                    question: "What is a newborn Giant Panda cub often compared to in size?",
                    arrayOfChoices: [
                        GeneratedChoice(choice: "A stick of butter", isCorrect: true),
                        GeneratedChoice(choice: "A small dog", isCorrect: false),
                        GeneratedChoice(choice: "A human baby", isCorrect: false),
                        GeneratedChoice(choice: "A football", isCorrect: false)
                    ],
                    selected: nil,
                    nextQuestion: nil
                )
            ]
        ),

        Quizzes(
            speciesName: "Oak Tree",
            imageUrl: "https://inaturalist-open-data.s3.amazonaws.com/photos/90880312/medium.jpg",
            generatedQuizzes: []
        ),

        Quizzes(
            speciesName: "Blue Whale",
            imageUrl: "https://static.inaturalist.org/photos/194385336/medium.jpg",
            generatedQuizzes: []
        ),

        Quizzes(
            speciesName: "Sunflower",
            imageUrl: "https://inaturalist-open-data.s3.amazonaws.com/photos/10802854/medium.jpg",
            generatedQuizzes: []
        )
    ]
    
    var isGeneratingQuizzes = false
    var error: String? = nil
    
//    init(autoGenerate: Bool = true) {
//        if autoGenerate {
//            loadQuizzes()
//        }
//    }
//    
    func loadQuizzes() {
        Task { [weak self] in
            guard let self else { return }
            await self.generateQuizzes()
        }
    }
    
    func generateQuizzes() async {
        isGeneratingQuizzes = true
        defer { isGeneratingQuizzes = false }
        
        var urlEndPoint: String { "http://127.0.0.1:5000/generate_quizz_route" }
        
        guard let url = URL(string: urlEndPoint) else {
            self.error = "Could not reach access to quizzes."
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let body = String(data: data, encoding: .utf8) { print(body) }
            
            do {
                let res = try JSONDecoder().decode([Quizzes].self, from: data)
                self.quizzes = res
                self.error = nil
            } catch {
                print("Failed to match format:", error.localizedDescription)
                self.error = "Failed to display quizzes"
                return
            }
        } catch {
            print("Failed to access URL:", error.localizedDescription)
            self.error = "Encoutered some issues while retrieving quizzes. Please try again later."
            return
        }
    }
}

