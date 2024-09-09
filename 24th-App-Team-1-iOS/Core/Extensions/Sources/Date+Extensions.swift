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
    
    func toFormatLocaleString(with format: String = "yyyy-MM") -> String {
        let dateFormatter = DateFormatter.withLocaleformat(format)
        return dateFormatter.string(from: self)
    }
    
    func toFormatString(with format: DateFormatter.Format) -> String {
        return toFormatString(with: format.type)
    }
    
    func toFormatLocaleString(with format: DateFormatter.Format) -> String {
        return toFormatLocaleString(with: format.type)
    }
    func toFormatRelative() -> String {
        
        let calendar = Calendar.current
        
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: .now) else {
            return self.toFormatString(with: .dashYyyyMMdd)
        }
        
        if calendar.isDate(self, inSameDayAs: sevenDaysAgo) {
            let relativeDateFormatter = RelativeDateTimeFormatter()
            relativeDateFormatter.unitsStyle = .short
            relativeDateFormatter.locale = Locale(identifier: "ko_KR")
            relativeDateFormatter.calendar = .autoupdatingCurrent
            
            return relativeDateFormatter.localizedString(for: self, relativeTo: .now)
        }
        
        return self.toFormatString(with: .dashYyyyMMdd)
    }
    
    func toCustomFormatRelative() -> String {
        let relativeDateformatter: RelativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateformatter.unitsStyle = .full
        relativeDateformatter.locale = Locale(identifier: "ko_KR")
        relativeDateformatter.calendar = .autoupdatingCurrent
        relativeDateformatter.dateTimeStyle = .numeric
        
        
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.second], from: self, to: now)
        if let second = components.second, second < 60 {
            return "방금"
        }
        
        return relativeDateformatter.localizedString(for: self, relativeTo: now)
    }
      
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
    
    func isFutureDay(_ otherDate: Date) -> Bool {
        let calendar = Calendar.current
        
        if calendar.isDate(self, inSameDayAs: otherDate) {
            return true
        }
        
        if calendar.isDateInYesterday(otherDate) || otherDate < self {
            return false
        } else {
            return true
        }
        
    }
}

public extension DateFormatter {
    enum Format {
        case m
        case mm
        case yyyyM
        case yyyyMM
        case yyyyMMdd
        case dashYyyyMM
        case dashYyyyMMdd
        case dashYyyyMMddhhmmss
        case ahhmmss
        case MddEEE
        case yyyyMMddYhhmmssXXX
        case yyyyMMddTHHmmssSSSSSS
        case yyyyMMddTHHmmssZ
        
        public var type: String {
            switch self {
            case .m:
                return "M월"
            case .mm:
                return "MM월"
            case .yyyyM:
                return "yyyy년 M월"
            case .yyyyMM:
                return "yyyy년 MM월"
            case .yyyyMMdd:
                return "yyyy년 MM월 dd일"
            case .dashYyyyMM:
                return "yyyy-MM"
            case .dashYyyyMMdd:
                return "yyyy-MM-dd"
            case .dashYyyyMMddhhmmss:
                return "yyyy-MM-dd hh:mm:ss"
            case .ahhmmss:
                return "a hh:mm:ss"
            case .yyyyMMddYhhmmssXXX:
                return "yyyy-MM-dd'T'HH:mm:ssXXX"
            case .yyyyMMddTHHmmssSSSSSS:
                return "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            case .yyyyMMddTHHmmssZ:
                return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .MddEEE:
                return "M월 dd일 EEEE"
            }
        }
    }
    
    static func withLocaleformat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    static func withFormat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    static func iso8601() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}
