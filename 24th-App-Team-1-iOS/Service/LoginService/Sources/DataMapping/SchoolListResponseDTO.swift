//
//  SchoolListResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation

import LoginDomain

public struct SchoolListResponseDTO: Decodable {
    public let schools: [SchoolListEntityDTO]
}

public struct SchoolListEntityDTO: Decodable {
    public let id: Int
    public let name: String
    public let address: String
    public let type: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case type
    }
}


extension SchoolListResponseDTO {
    func toDomain() -> SchoolListResponseEntity {
        return .init(schools: schools.map { $0.toDomain() })
    }
}

extension SchoolListEntityDTO {
    func toDomain() -> SchoolListEntity {
        return .init(id: id, name: name, address: address, type: SchoolType(rawValue: type) ?? .middle)
    }
}
