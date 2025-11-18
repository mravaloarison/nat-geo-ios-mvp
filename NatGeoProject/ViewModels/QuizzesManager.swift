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
    var quizzes: [Quizzes] = []
    var isGeneratingQuizzes = false
    var error: String? = nil
    
    init(autoGenerate: Bool = true) {
        if autoGenerate {
            loadQuizzes()
        }
    }
    
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

