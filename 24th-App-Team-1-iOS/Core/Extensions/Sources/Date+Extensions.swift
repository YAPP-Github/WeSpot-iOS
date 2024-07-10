//
//  Date+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/11/24.
//

import Foundation


public extension Date {
    func toFormatString(with format: String = "yyyy-MM") -> String {
        let dateFormatter = DateFormatter.withFormat(format)
        return dateFormatter.string(from: self)
    }
}


public extension DateFormatter {
    static func withFormat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale.autoupdatingCurrent
        return formatter
    }
}
