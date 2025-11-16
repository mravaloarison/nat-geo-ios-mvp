//
//  ObservationManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/29/25.
//

import Foundation
import Observation

@MainActor
@Observable class ObservationManager {
    var selectedObservation: ObservationM? = nil
    var observationId: Int? = nil
    var isLoadingObservation: Bool = false
    
    init(_ observationId: Int? = nil) {
        self.observationId = observationId
    }
    
    var urlString: String {
        "https://api.inaturalist.org/v1/observations/\(observationId ?? 0)"
    }
    
    func getData() async {
        isLoadingObservation = true
        defer { isLoadingObservation = false }
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(ObservationResponse.self, from: data) else {
                print("Could not decode returned JSON data")
                return
            }
            
            self.selectedObservation = returned.results.first
                        
        } catch {
            print("Could not get data from: \(urlString)")
        }
    }
}
