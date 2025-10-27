//
//  GeocodeService.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import MapKit

struct GeocodeService {
    static func reverseGeocode(coordinate: CLLocationCoordinate2D) async throws -> String {
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
