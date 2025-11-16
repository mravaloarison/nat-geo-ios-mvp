//
//  ObservationCarousselView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/29/25.
//

import SwiftUI

struct ObservationCarouselView: View {
    let photos: [ObservationPhoto]
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(spacing: 0) {
            carousel
                .frame(height: 450)
                .tabViewStyle(.page)
            attribution
        }
    }
    
    var carousel: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(photos.enumerated()), id: \.element.id) { index, photoWrapper in
                AsyncImage(url: URL(string: photoWrapper.url?.toOriginal ?? "https://")) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: { Color.gray.opacity(0.3) }
                .tag(index)
            }
        }
    }
    
    var attribution: some View {
        Text(photos[selectedIndex].attribution ?? "(c) No attribution")
            .font(.caption)
            .foregroundColor(.secondary)
            .padding()
            .multilineTextAlignment(.center)
    }
}
