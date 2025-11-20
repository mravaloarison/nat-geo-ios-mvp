//
//  NewsManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/19/25.
//

import Foundation
import Observation

struct NewsResults: Codable, Hashable {
    var articles: [NewsArticle]
}

struct NewsArticle: Codable, Hashable {
    var publishedAt: String
    var source: Source
    var title: String
    var url: String
    var urlToImage: String
}

struct Source: Codable, Hashable {
    var id: String?
    var name: String
}

@MainActor
@Observable class NewsManager {
    var scienceNews: [NewsArticle] = []
    var natGeoNews: [NewsArticle] = []
    
    var isGeneratingNews = false
    var error: String? = nil
    
    init(autoGenerate: Bool = true) {
        if autoGenerate {
            loadNews()
        }
    }
    
    func loadNews() {
        Task { [weak self] in
            guard let self else { return }
            await self.getScienceNews()
        }
    }
    
    func getScienceNews() async {
        isGeneratingNews = true
        defer { isGeneratingNews = false }
        
        var urlEndPoint: String { "http://127.0.0.1:5000/science_news" }
        
        guard let url = URL(string: urlEndPoint) else {
            self.error = "Could not reach access to science news."
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let body = String(data: data, encoding: .utf8) { print(body) }
            
            do {
                let res = try JSONDecoder().decode(NewsResults.self, from: data)
                self.scienceNews = res.articles
                self.error = nil
            } catch {
                print("Failed to match format:", error.localizedDescription)
                self.error = "Failed to display science news"
                return
            }
        } catch {
            print("Failed to access URL:", error.localizedDescription)
            self.error = "Encoutered some issues while retrieving science news. Please try again later."
            return
        }
    }
    
    func getNatGeoNews() async {
        isGeneratingNews = true
        defer { isGeneratingNews = false }
        
        var urlEndPoint: String { "http://127.0.0.1:5000/nat_geo" }
        
        guard let url = URL(string: urlEndPoint) else {
            self.error = "Could not reach access to Nat Geo."
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let body = String(data: data, encoding: .utf8) { print(body) }
            
            do {
                let res = try JSONDecoder().decode(NewsResults.self, from: data)
                self.natGeoNews = res.articles
                self.error = nil
            } catch {
                print("Failed to match format:", error.localizedDescription)
                self.error = "Failed to display Nat Geo"
                return
            }
        } catch {
            print("Failed to access URL:", error.localizedDescription)
            self.error = "Encoutered some issues while retrieving Nat Geo. Please try again later."
            return
        }
    }
}
