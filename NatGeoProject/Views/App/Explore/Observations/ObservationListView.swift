//
//  ObservationListView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
internal import _LocationEssentials

struct ObservationListView: View {
    @Environment(ExploreManager.self) var exploreManager
    @Binding var showListView: Bool
    @Binding var showFiltersView: Bool
    
    var body: some View {
        Group {
            if exploreManager.lat == 0.0 || exploreManager.lng == 0.0 {
                NoMapsView()
            } else {
                content
                    .customNavigation(
                        title: {
                            if exploreManager.isLoadingSpecies {
                                return "Loading observations ..."
                            } else {
                                return exploreManager.totalResult > 0 ? "\(formatToDec(exploreManager.totalResult)) Observations" : "Observations Near You"
                            }
                        }(),
                        backAction: { showListView = false },
                        showFilters: { showFiltersView = true }
                    )
                    .sheet(isPresented: $showFiltersView) {
        //                ObservationFiltersView()
                    }
            }
        }
    }
    
    var content: some View {
        Group {
            if exploreManager.isLoadingSpecies {
                ProgressView()
            } else {
                lisOfObservations
                    .listStyle(.plain)
            }
        }
    }
    
    var lisOfObservations: some View {
        List {
            let observations = exploreManager.speciesResult
            
            ForEach(0..<observations.count, id: \.self) { index in
                LazyVStack {
                    NavigationLink {
                        Text(observations[index].species_guess ?? "Unknown species")
                    } label: {
                        ObservationResultView(
                            observations: observations,
                            index: index
                        )
                    }
                }
            }
        }
    }
}
