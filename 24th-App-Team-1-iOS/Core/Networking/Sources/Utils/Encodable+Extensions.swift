//
//  Encodable+Extensions.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation


extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
