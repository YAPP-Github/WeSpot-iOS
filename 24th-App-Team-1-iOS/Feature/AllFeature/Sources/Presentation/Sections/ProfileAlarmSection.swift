//
//  ProfileAlarmSection.swift
//  AllFeature
//
//  Created by Kim dohyun on 8/15/24.
//

import Differentiator

public enum ProfileAlarmSection: SectionModelType {
    case alarmInfo([ProfileAlarmItem])
    
    public var items: [ProfileAlarmItem] {
        if case let .alarmInfo(items) = self {
            return items
        }
        return []
    }
    
    public init(original: ProfileAlarmSection, items: [ProfileAlarmItem]) {
        self = original
    }
}


public enum ProfileAlarmItem {
    case profileAlarmItem(ProfileAlarmCellReactor)
}
