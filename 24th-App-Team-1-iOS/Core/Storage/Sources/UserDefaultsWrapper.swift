//
//  UserDefaultsWrapper.swift
//  Util
//
//  Created by eunseou on 7/30/24.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T?
    
    public init(key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T? {
        get {
            if let value = UserDefaults.standard.object(forKey: key) as? T {
                return value
            }
            return defaultValue
        }
        set {
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
