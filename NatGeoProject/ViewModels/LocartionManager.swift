//
//  LocartionManager.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
import MapKit
import Observation

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
                let address = try await self?.reverseGeocode(coordinate: CLLocationCoordinate2D(latitude: lastCoord.latitude, longitude: lastCoord.longitude))
                await MainActor.run {
                    self?.userLocation.displayText = address ?? ""
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
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) async throws -> String {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        guard let request = MKReverseGeocodingRequest(location: location) else {
            throw GeocodeError.invalidLocation
        }
        
        let mapItems = try await request.mapItems
        
        guard let firstItem = mapItems.first,
              let address = firstItem.address?.fullAddress else {
            throw GeocodeError.addressNotFound
        }
        
        return address
    }
    
    enum GeocodeError: LocalizedError {
        case invalidLocation
        case addressNotFound
        
        var errorDescription: String? {
            switch self {
            case .invalidLocation:
                return "Could not create location from coordinates"
            case .addressNotFound:
                return "Could not find address for location"
            }
        }
    }
}
