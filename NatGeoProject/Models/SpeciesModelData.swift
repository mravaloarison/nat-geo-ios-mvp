//
//  SpeciesModelData.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import Foundation
internal import CoreLocation

// MARK: - List Of Observations Response
struct ObservedSpecies: Codable {
    let total_results: Double
    let results: [ObservationResult]
}

struct ObservationResult: Codable {
    let species_guess: String?
    let taxon: Taxon?
    let user: Observer?
    let geojson: ObservationCoordinate?
    let location: String?
    let time_observed_at: String?
    let id: Int?
    
    var resolvedAddress: String?

    var latitude: Double? {
        if let lat = geojson?.coordinates.last {
            return lat
        }
        if let parts = location?.split(separator: ","), parts.count == 2,
           let lat = Double(parts[0].trimmingCharacters(in: .whitespaces)) {
            return lat
        }
        return nil
    }
    
    var longitude: Double? {
        if let lon = geojson?.coordinates.first {
            return lon
        }
        if let parts = location?.split(separator: ","), parts.count == 2,
           let lon = Double(parts[1].trimmingCharacters(in: .whitespaces)) {
            return lon
        }
        return nil
    }
    
    var relativeTime: String? {
        guard let timeString = time_observed_at else { return nil }
        return DateUtils.relativeTimeString(from: timeString)
    }
    
    enum CodingKeys: String, CodingKey {
        case species_guess
        case taxon
        case user
        case geojson
        case location
        case time_observed_at
        case id
    }
}

struct Taxon: Codable {
    let id: Double?
    let name: String?
    let default_photo: DefaultSpeciesPhoto?
}

struct DefaultSpeciesPhoto: Codable {
    let attribution: String?
    let url: String?
}

struct Observer: Codable {
    let id: Double?
    let login: String?
    let name: String?
}

struct ObservationCoordinate: Codable {
    let coordinates: [Double]
}

// MARK: - Species Search Response
struct TaxonSearchResult: Codable {
    let taxon_id: Int
    let common_name: String?
    let scientific_name: String
    let image: String?
}

struct SearchResponse: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let type: String
    let record: TaxonRecord?
}

struct TaxonRecord: Codable {
    let id: Int
    let preferred_common_name: String?
    let name: String
    let rank: String?
    let default_photo: TaxonPhoto?
}

struct TaxonPhoto: Codable {
    let medium_url: String?
}

// MARK: - Observation Response
struct ObservationResponse: Codable {
    let total_results: Int
    let results: [ObservationM]
}

struct ObservationM: Codable, Identifiable {
    let id: Int
    let uuid: String
    let quality_grade: String
    let time_observed_at: String?
    let taxon: ObservationTaxon?
    let user: ObservationUser
    let photos: [ObservationPhoto]
    let place_guess: String?
    let location: String?
    let observed_on: String?
    let description: String?
    let identifications_count: Int
    let comments_count: Int
    let faves_count: Int
    let uri: String
}

struct ObservationTaxon: Codable {
    let id: Int
    let name: String
    let rank: String
    let preferred_common_name: String?
    let iconic_taxon_name: String?
    let wikipedia_url: String?
    let wikipedia_summary: String?
    let default_photo: ObservationDefaultPhoto?
    let observations_count: Int
}

struct ObservationDefaultPhoto: Codable {
    let id: Int?
    let url: String?
    let attribution: String?
}

struct ObservationPhoto: Codable, Identifiable {
    let id: Int
    let license_code: String?
    let url: String?
    let attribution: String?
    let original_dimensions: PhotoDimensions?
}

struct PhotoDimensions: Codable {
    let width: Int
    let height: Int
}

struct ObservationUser: Codable {
    let id: Int
    let login: String
    let name: String?
    let icon_url: String?
}
