//
//  SchoolRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct SchoolListRequestDTO: Encodable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}


