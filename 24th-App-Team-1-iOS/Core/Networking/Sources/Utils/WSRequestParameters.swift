//
//  WSRequestParameters.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation


public enum WSRequestParameters {
    case requestQuery(_ parameter: Encodable?)
    case requestBody(_ parameter: Encodable?)
    case reuqestQueryWithBody(_ query: Encodable?, body: Encodable?)
}
