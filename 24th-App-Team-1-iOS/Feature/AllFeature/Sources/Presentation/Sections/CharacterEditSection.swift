//
//  CharacterEditSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/14/24.
//

import Differentiator

public enum CharacterEditSection: SectionModelType {
    case profileCharacterInfo([CharacterEditItem])
    
    public var items: [CharacterEditItem] {
        if case let .profileCharacterInfo(items) = self {
            return items
        }
        return []
    }
    
    
    public init(original: CharacterEditSection, items: [CharacterEditItem]) {
        self = original
    }
}

public enum CharacterEditItem {
    case profileCharacterItem(ProfileCharacterCellReactor)
}
