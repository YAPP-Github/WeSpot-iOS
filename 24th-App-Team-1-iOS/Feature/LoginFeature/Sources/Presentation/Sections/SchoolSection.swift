//
//  SchoolSection.swift
//  LoginFeature
//
//  Created by eunseou on 8/3/24.
//

import Foundation
import Differentiator
import LoginDomain

public enum SchoolSection: SectionModelType {
    case schoolInfo([SchoolItem])
    
    public var items: [SchoolItem] {
        switch self {
        case .schoolInfo(let items):
            return items
        }
    }
    
    public init(original: SchoolSection, items: [SchoolItem]) {
        switch original {
        case .schoolInfo:
            self = .schoolInfo(items)
        }
    }
}

public struct SchoolItem {
    let school: SchoolListEntity
    
    public init(school: SchoolListEntity) {
        self.school = school
    }
}
