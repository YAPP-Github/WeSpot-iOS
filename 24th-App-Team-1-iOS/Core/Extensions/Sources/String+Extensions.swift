//
//  String+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 8/8/24.
//

import Foundation

public extension String {
    func toDate(with format: String) -> Date {
        let dateFormatter = DateFormatter.withFormat(format)
        guard let date = dateFormatter.date(from: self) else { return .now }
        
        return date
    }
    
    func toDate(with format: DateFormatter.Format) -> Date {
        return toDate(with: format.type)
    }
}
