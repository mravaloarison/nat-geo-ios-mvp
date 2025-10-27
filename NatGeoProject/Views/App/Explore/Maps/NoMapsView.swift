//
//  NoMapsView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct NoMapsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            locationIcon
            permissionMessage
            actionButton
            Spacer()
        }
        .padding(32)
    }
    
    var locationIcon: some View {
        Image(systemName: "location.circle")
            .font(.system(size: 60))
            .foregroundStyle(
                LinearGradient(
                    colors: [.gray, .secondary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
    
    var permissionMessage: some View {
        VStack(spacing: 12) {
            Text("Location Access Needed")
                .font(.title2)
                .fontWeight(.bold)
            Text("We need your location to show nearby species and nature observations around you.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    var actionButton: some View {
        Button(action: openSettings) {
            Text("Open Settings")
                .font(.subheadline)
                .padding()
        }
        .glassEffect(in: .rect(cornerRadius: 16))
    }
    
    private func openSettings() {
        UIApplication.shared.open(
            URL(string: UIApplication.openSettingsURLString)!,
            options: [:],
            completionHandler: nil
        )
    }
}
