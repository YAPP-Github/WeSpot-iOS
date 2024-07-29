//
//  UserDefaultsWrapper.swift
//  Util
//
//  Created by eunseou on 7/30/24.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T: Codable> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults
    
    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: T {
        get {
            if let data = userDefaults.data(forKey: key),
               let value = try? JSONDecoder().decode(T.self, from: data) {
                return value
            }
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encoded, forKey: key)
            }
            
        }
    }
}
