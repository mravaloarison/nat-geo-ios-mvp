//
//  utils.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI

struct DateUtils {
    /// inputs 12:45PM 12/20/2025EST -> outputs 3h ago
    static func relativeTimeString(from isoString: String) -> String? {
        guard let date = ISO8601DateFormatter().date(from: isoString) else {
            return nil
        }
        
        let now = Date()
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date,
            to: now
        )
        
        if let years = components.year, years > 0 {
            return "\(years)y ago"
        } else if let months = components.month, months > 0 {
            return "\(months)mo ago"
        } else if let days = components.day, days > 0 {
            return "\(days)d ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m ago"
        } else {
            return "just now"
        }
    }
}

func formatToDec(_ decimal: Double?) -> String {
    guard let decimal else { return "" }
    
    let absValue = abs(decimal)
    let sign = decimal < 0 ? "-" : ""
    
    switch absValue {
    case 1_000_000_000...:
        return "\(sign)\(String(format: "%.1f", absValue / 1_000_000_000))B"
    case 1_000_000...:
        return "\(sign)\(String(format: "%.1f", absValue / 1_000_000))M"
    case 1_000...:
        return "\(sign)\(String(format: "%.1f", absValue / 1_000))K"
    default:
        return NumberFormatter.localizedString(from: NSNumber(value: decimal), number: .decimal)
    }
}
