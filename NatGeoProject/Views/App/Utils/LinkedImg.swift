//
//  LinkedImg.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct LinkedImg: View {
    let imageClipShape = RoundedRectangle(cornerRadius: 16, style: .continuous)
    let link: String
    let w, y: Double

    var body: some View {
        AsyncImage(url: URL(string: link)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: w, height: y)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: w, height: y)
                    .clipShape(imageClipShape)
                    .foregroundColor(.gray)
            case .empty:
                ProgressView()
                    .frame(width: w, height: y)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    LinkedImg(link: "",w: 30, y: 30)
}
