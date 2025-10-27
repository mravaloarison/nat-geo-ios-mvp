//
//  MapsView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
import MapKit

struct MapsView: View {
    @State private var cameraPostion: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $cameraPostion) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
        }
    }
}


#Preview {
    MapsView()
}
