//
//  Data+Extensions.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation


extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let jsonString = String(data: data, encoding: .utf8) else { return nil }
        return jsonString
    }
}
