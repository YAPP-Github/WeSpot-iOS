//
//  ReservedMessageSection.swift
//  MessageFeature
//
//  Created by eunseou on 7/21/24.
//

import UIKit

import Differentiator

enum ReservedMessageSection: SectionModelType {
    case main([ReservedMessageItem])
    
    var items: [ReservedMessageItem] {
        switch self {
        case .main(let items):
            return items
        }
    }
    
    init(original: ReservedMessageSection, items: [Item]) {
        switch original {
        case .main:
            self = .main(items)
        }
    }
}

public struct ReservedMessageItem {
    let reciptent: String
    let profile: UIImage?
}
