//
//  Bundle+Extensions.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation


extension Bundle {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            return ""
        }
        return url
    }
}
