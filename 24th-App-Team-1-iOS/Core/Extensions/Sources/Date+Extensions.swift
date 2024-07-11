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
    
    func toFormatString(with format: DateFormatter.Format) -> String {
        return toFormatString(with: format.type)
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
            case .MddEEE:
                return "M월 dd일 EEEE"
            }
        }
    }
    
    static func withFormat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}
