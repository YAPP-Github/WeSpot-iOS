//
//  SchoolListEntity.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct SchoolListResponseEntity {
    public let schools: [SchoolListEntity]
    
    public init(schools: [SchoolListEntity]) {
        self.schools = schools
    }
}


// 학교 검색 API
public enum SchoolType: String {
    case middle = "중학교"
    case high = "고등학교"
}

public struct SchoolListEntity: Equatable {
    public let id: Int
    public let name: String
    public let address: String
    public let type: SchoolType
    
    public init(id: Int, name: String, address: String, type: SchoolType) {
        self.id = id
        self.name = name
        self.address = address
        self.type = type
    }
}


