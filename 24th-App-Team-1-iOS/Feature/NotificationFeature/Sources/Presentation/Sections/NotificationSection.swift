//
//  NotificationSection.swift
//  NotificationFeature
//
//  Created by Kim dohyun on 8/19/24.
//

import Differentiator

public enum NotificationSection: SectionModelType {
    case notificationInfo([NotificationItem])
    
    public var items: [NotificationItem] {
        if case let .notificationInfo(items) = self {
            return items
        }
        return []
    }
    public init(original: NotificationSection, items: [NotificationItem]) {
        self = original
    }
    
}

public enum NotificationItem {
    case userNotificationItem(NotificationCellReactor)
}
