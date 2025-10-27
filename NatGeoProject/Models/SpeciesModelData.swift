//
//  SpeciesModelData.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import Foundation
import CoreLocation

/// Observation list
struct ObservedSpecies: Codable {
    let total_results: Double
    let results: [Observation]
}

struct Observation: Codable {
    let species_guess: String?
    let taxon: Taxon?
    let user: Observer?
    let geojson: ObservationCoordinate?
    let location: String?
    let time_observed_at: String?
    
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

/// Search autocomplete results
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
