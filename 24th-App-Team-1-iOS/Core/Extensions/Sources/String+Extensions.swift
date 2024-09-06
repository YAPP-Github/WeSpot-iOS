//
//  String+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 8/8/24.
//

import Foundation

public extension String {
    func toDate(with format: String = "yyyy-MM") -> Date {
        let dateFormatter = DateFormatter.withFormat(format)
        guard let date = dateFormatter.date(from: self) else {
            return .now
        }
        
        return date
    }
    
    func toLocalDate(with format: String = "yyyy-MM") -> Date {
        let dateFormatter = DateFormatter.withLocaleformat(format)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = dateFormatter.date(from: self) else { return .now }
        let timeZoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(timeZoneOffset)
    }
    
    func toDate(with format: DateFormatter.Format) -> Date {
        return toDate(with: format.type)
    }
    
    func toLocalDate(with format: DateFormatter.Format) -> Date {
        return toLocalDate(with: format.type)
    }
}
