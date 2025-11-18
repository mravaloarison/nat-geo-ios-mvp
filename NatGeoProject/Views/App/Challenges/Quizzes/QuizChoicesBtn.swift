//
//  QuizChoicesBtn.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 11/18/25.
//

import SwiftUI

struct QuizChoicesBtn: View {
    let choice: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(choice)
        }
        .buttonStyle(ChoiceButtonStyle(isSelected: isSelected))
    }
}

#Preview {
    QuizChoicesBtn(
        choice: "ABC",
        isSelected: true,
        action: { print("Hi") }
    )
    .padding()
}

struct ChoiceButtonStyle: ButtonStyle {
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(isSelected ? Color.gray.opacity(0.20) : Color.secondary.opacity(0.09))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(lineWidth: isSelected ? 1.2 : 1)
                .foregroundStyle(isSelected ? Color.primary : Color.secondary.opacity(0.9))
            )
    }
}
