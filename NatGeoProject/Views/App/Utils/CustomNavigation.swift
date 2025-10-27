//
//  CustomNavigation.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct CustomNavigationModifier: ViewModifier {
    let title: String
    let backAction: () -> Void
    let showFilters: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    goBackBtn
                }
                ToolbarItem(placement: .topBarTrailing) {
                    filtersBtn
                }
            }
    }
    
    var goBackBtn: some View {
        Button(action: backAction) {
            Image(systemName: "chevron.left")
            Image(systemName: "map")
        }
    }
    
    var filtersBtn: some View {
        Button(action: showFilters ?? {}) {
            Image(systemName: "slider.vertical.3")
        }
    }
}

extension View {
    func customNavigation(
        title: String,
        backAction: @escaping () -> Void,
        showFilters: (() -> Void)? = nil
    ) -> some View {
        modifier(CustomNavigationModifier(
            title: title,
            backAction: backAction,
            showFilters: showFilters
        ))
    }
}
