//
//  Constants.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct TabItem {
    let icon: String
    let label: String
    let view: AnyView
}

struct Constants {
    static let cornerRadius: CGFloat = 15.0
    static let standardPadding: CGFloat = 14.0
    
    static let landmarkListItemAspectRatio: CGFloat = 1.0
    static let landmarkListPercentOfHeight: CGFloat = 0.3
    static let landmarkListMinimumHeight: CGFloat = 140.0
}
