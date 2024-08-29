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
    static let showVoteMainViewController = Notification.Name("showVoteMainViewController")
    static let showSignInViewController = Notification.Name("showSignInViewController")
    static let showNotifcationViewController = Notification.Name("showNotificationViewController")
    static let showVoteProccessController = Notification.Name("showVoteProccssViewController")
    static let showVoteCompleteViewController = Notification.Name("showVoteCompleteViewController")
    static let showVoteEffectViewController = Notification.Name("showVoteEffectViewController")
    static let showVoteInventoryViewController = Notification.Name("showVoteInventoryViewController")
    static let showProfileImageViewController = Notification.Name("showProfileImageViewController")
}
