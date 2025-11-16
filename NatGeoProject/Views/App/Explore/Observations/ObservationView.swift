//
//  ObservationView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/29/25.
//

import SwiftUI

struct ObservationView: View {
    let observationManager: ObservationManager
    @State private var selectedPhotoIndex = 0
    
    var body: some View {
        ScrollView {
            if let observation = observationManager.selectedObservation {
                VStack(alignment: .leading, spacing: 0) {
                    ObservationCarouselView(photos: observation.photos, selectedIndex: $selectedPhotoIndex)
                }
            }
        }
        .task {
            await observationManager.getData()
            print(observationManager.observationId ?? "Printing onservtion")
        }
        .ignoresSafeArea(edges: .top)
    }
}


// MARK: - Preview
#Preview {
    NavigationView {
        ObservationView(observationManager: ObservationManager(323877949))
            .navigationBarTitleDisplayMode(.inline)
    }
}
