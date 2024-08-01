//
//  APNsToken.swift
//  Storage
//
//  Created by eunseou on 8/1/24.
//

import Foundation

public class APNsTokenManager {
    public static let shared = APNsTokenManager()
    private init() {}

    public var token: String?
}
