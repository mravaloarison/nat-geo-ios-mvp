//
//  ResultListView.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct ResultListView: View {
    var taxon: TaxonSearchResult
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            LinkedImg(
                link: taxon.image ?? "https://",
                w: 60, y: 60
            )
            content
                .font(.title3)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            speciesName
            scientificName
        }
    }
    
    var speciesName: some View {
        Text(taxon.common_name ?? "No Common Name")
            .bold()
    }
    
    var scientificName: some View {
        Text(taxon.scientific_name)
            .foregroundColor(.secondary)
    }
}

//#Preview {
//    ResultListView()
//}
