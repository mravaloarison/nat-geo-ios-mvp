//
//  UserLocationView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
internal import CoreLocation

struct UserLocationView: View {
    var manageLocation: LocationManager
    
    var body: some View {
        content
    }
    
    var content: some View {
        HStack {
            Image(systemName: "iphone.badge.location")
            location
            Spacer()
            Image(systemName: "gearshape.fill")
        }
        .padding()
    }
    
    var location: some View {
        VStack(alignment: .leading) {
            Text("Device Location")
                .font(.footnote)
                .bold()
            Text(manageLocation.userLocation.displayText ?? "No location detected")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    UserLocationView(manageLocation: LocationManager())
}
