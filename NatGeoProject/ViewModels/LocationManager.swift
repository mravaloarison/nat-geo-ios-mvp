//
//  LocationManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
import MapKit

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored let manager = CLLocationManager()
    var userLocation = UserLocation(isAuthorized: false)
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func startLocationServices() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            userLocation.isAuthorized = true
        } else {
            userLocation.isAuthorized = false
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation.coordinate = locations.last
        guard let lastCoord = userLocation.coordinate?.coordinate else { return }
        Task { [weak self] in
            do {
                let address = try await GeocodeService.reverseGeocode(coordinate: CLLocationCoordinate2D(latitude: lastCoord.latitude, longitude: lastCoord.longitude))
                await MainActor.run {
                    self?.userLocation.displayText = address
                }
            } catch {
                await MainActor.run {
                    self?.userLocation.displayText = "Unable to determine address"
                }
                print("Reverse geocoding failed: \(error.localizedDescription)")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            userLocation.isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .restricted:
            userLocation.isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            userLocation.isAuthorized = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            userLocation.isAuthorized = true
            manager.requestLocation()
        @unknown default:
            userLocation.isAuthorized = true
            startLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
