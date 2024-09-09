//
//  SignUpProfileSection.swift
//  LoginFeature
//
//  Created by Kim dohyun on 8/29/24.
//

import Foundation


import UIKit
import Differentiator
import CommonDomain

public enum SignUpCharacterSection: SectionModelType {
    case setupCharacterSection([SignUpCharacterItem])
    
    public var items: [SignUpCharacterItem] {
        if case let .setupCharacterSection(items) = self {
            return items
        }
        return []
    }
    
    
    public init(original: SignUpCharacterSection, items: [SignUpCharacterItem]) {
        self = original
    }
}

public enum SignUpCharacterItem {
    case characterItem(SignUpProfileCharacterCellReactor)
}


public enum SignUpBackgroundSection: SectionModelType {
    case setupBackgroundSection([SignUpBackgroundItem])
    
    
    public var items: [SignUpBackgroundItem] {
        if case let .setupBackgroundSection(items) = self {
            return items
        }
        return []
    }

    public init(original: SignUpBackgroundSection, items: [SignUpBackgroundItem]) {
        self = original
    }
}


public enum SignUpBackgroundItem {
    case backgroundItem(SignUpProfileBackgroundCellReactor)
}
