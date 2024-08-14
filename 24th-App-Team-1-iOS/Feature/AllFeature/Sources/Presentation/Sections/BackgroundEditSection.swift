//
//  BackgroundEditSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/14/24.
//

import Differentiator


public enum BackgroundEditSection: SectionModelType {
    case profileBackgroundInfo([BackgroundEditItem])
    
    
    public var items: [BackgroundEditItem] {
        if case let .profileBackgroundInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: BackgroundEditSection, items: [BackgroundEditItem]) {
        self = original
    }
    
}

public enum BackgroundEditItem {
    case profileBackgroundItem(ProfileBackgroundCellReactor)
}
