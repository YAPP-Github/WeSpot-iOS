//
//  ReportMessageSection.swift
//  MessageFeature
//
//  Created by eunseou on 7/24/24.
//

import Foundation

import Differentiator


enum ReportMessageSection: SectionModelType {
    case main([ReportReason])
    
    var items: [ReportReason] {
        switch self {
        case .main(let items):
            return items
        }
    }
    
    init(original: ReportMessageSection, items: [ReportReason]) {
        switch original {
        case .main:
            self = .main(items)
        }
    }
}

public struct ReportReason: IdentifiableType, Equatable {
    public typealias Identity = Int
    
    public var id: Int
    public var description: String
    public var isSelected: Bool
    
    public var identity: Int {
        return id
    }
    
    public init(id: Int, description: String, isSelected: Bool) {
        self.id = id
        self.description = description
        self.isSelected = isSelected
    }
}
