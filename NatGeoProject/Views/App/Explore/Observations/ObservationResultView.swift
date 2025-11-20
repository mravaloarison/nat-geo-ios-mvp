//
//  ObservationResultView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ObservationResultView: View {
    let observations: [ObservationResult]
    let index: Int
    private var item: ObservationResult { observations[index] }
    
    var body: some View {
        HStack(spacing: 12) {
            LinkedImg(
                link: item.taxon?.default_photo?.url ?? "https://",
                w: 90, y: 90
            )
            content
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            speciesName
            observerName
            Spacer(minLength: 4)
            
            timeFrame
        }
        .frame(maxHeight: .infinity)
    }
    
    var speciesName: some View {
            HStack(alignment: .lastTextBaseline) {
                Text(item.species_guess ?? item.taxon?.name ?? "Unknown species")
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(item.relativeTime ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    
    var observerName: some View {
        Text("By \(item.user?.name ?? item.user?.login ?? "Unknown user")")
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
    
    var timeFrame: some View {
        Text(item.resolvedAddress ?? item.location ?? "No precise location")
            .font(.footnote)
            .lineLimit(2)
            .foregroundColor(.secondary)
    }
}

