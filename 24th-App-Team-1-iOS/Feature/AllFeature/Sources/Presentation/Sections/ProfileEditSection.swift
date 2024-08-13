//
//  ProfileEditSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/13/24.
//

import Differentiator


public enum ProfileEditSection: SectionModelType {
    case profileBackgroundInfo([ProfileEditItem])
    case profileCharacterInfo([ProfileEditItem])
    
    
    public var items: [ProfileEditItem] {
        switch self {
        case let .profileBackgroundInfo(items): return items
        case let .profileCharacterInfo(items): return items
        }
    }
    
    public init(original: ProfileEditSection, items: [ProfileEditItem]) {
        self = original
    }
    
}

public enum ProfileEditItem {
    case profileBackgroundItem(ProfileBackgroundCellReactor)
    case profileCharacterItem(ProfileCharacterCellReactor)
}
