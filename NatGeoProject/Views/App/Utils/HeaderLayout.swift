//
//  HeaderLayout.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct HeaderLayout: View {
    var tab: String
    
    var body: some View {
        VStack {
            HStack {
                title
                Spacer()
                userProfile
            }
        }
    }
    
    var title: some View {
        Text(tab)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var userProfile: some View {
        Image(systemName: "person")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .clipShape(Circle())
    }
}
