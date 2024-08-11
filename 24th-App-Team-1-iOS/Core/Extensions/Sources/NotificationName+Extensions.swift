//
//  NotificationName+Extensions.swift
//  Extensions
//
//  Created by eunseou on 7/29/24.
//

import Foundation

public extension Notification.Name {
    static let hideTabBar = Notification.Name("hideTabBar")
    static let showTabBar = Notification.Name("showTabBar")
    static let FCMToken = Notification.Name("FCMToken")
    static let userDidLogin = Notification.Name("userDidLogin")
}
