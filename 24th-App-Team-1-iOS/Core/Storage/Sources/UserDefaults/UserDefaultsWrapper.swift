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
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            
            let decoder = JSONDecoder()
            do {
                let value = try decoder.decode(T.self, from: data)
                return value
            } catch {
                return defaultValue
            }
        }
        set {
            let encoder = JSONEncoder()
             do {
                 let data = try encoder.encode(newValue)
                 UserDefaults.standard.set(data, forKey: key)
             } catch {
                 print("Encoding failed: \(error)")
             }
        }
    }
}
