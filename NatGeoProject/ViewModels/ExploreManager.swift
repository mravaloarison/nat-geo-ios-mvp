//
//  ExploreManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import Foundation
import Observation
import MapKit

@MainActor
@Observable class ExploreManager {
    var manageLocation = LocationManager()
    var speciesResult: [ObservationResult] = []
    var isLoadingSpecies = false
    var pageNumber = 1
    var totalResult = 0.0
    var lat: Double { manageLocation.userLocation.coordinate?.coordinate.latitude ?? 0.0 }
    var lng: Double { manageLocation.userLocation.coordinate?.coordinate.longitude ?? 0.0 }
    
    var urlString: String {
        "https://api.inaturalist.org/v1/observations?verifiable=true&page=\(pageNumber)&lat=\(lat)&lng=\(lng)&radius=10"
    }
    
    func getData() async {
        isLoadingSpecies = true
        defer { isLoadingSpecies = false }
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(ObservedSpecies.self, from: data) else {
                print("Could not decode returned JSON data")
                return
            }
            
            self.speciesResult = returned.results
            self.totalResult = returned.total_results
            
            await resolveAddresses()
            
        } catch {
            print("Could not get data from: \(urlString)")
        }
    }
    
    private func resolveAddresses() async {
        for (index, item) in speciesResult.enumerated() {
            guard let lat = item.latitude, let lon = item.longitude else { continue }
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            do {
                let resolved = try await GeocodeService.reverseGeocode(coordinate: coordinate)
                speciesResult[index].resolvedAddress = resolved
            } catch {
                print("Failed to reverse geocode for item \(index): \(error.localizedDescription)")
                speciesResult[index].resolvedAddress = "Address unavailable"
            }
        }
    }
}
