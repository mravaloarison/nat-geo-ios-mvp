//
//  FunFactHorizontalListView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/12/25.
//

import SwiftUI

struct FunFactHorizontalListView: View {
    let funfacts: [FunFact]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Did You Know?")
                .font(.title2.bold())
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(funfacts, id: \.fact) { fact in
                        NavigationLink{
                            Text(fact.specie)
                        } label: {
                            FunFactView(funFact: fact)
                                .frame(width: 280, height: 200)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FunFactHorizontalListView(funfacts: [
        FunFact(
            specie: "Octopus",
            fact: "Lençóis Maranhenses National Park covers approximately 380,000 acres on the northeastern coast of Brazil.",
            image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg"
        ),
        FunFact(
            specie: "Blue Whale",
            fact: "The blue whale's heart can weigh as much as a car and beats only 5-6 times per minute when diving.",
            image_url: "https://inaturalist-open-data.s3.amazonaws.com/photos/59737507/medium.jpg"
        )
    ])
}
