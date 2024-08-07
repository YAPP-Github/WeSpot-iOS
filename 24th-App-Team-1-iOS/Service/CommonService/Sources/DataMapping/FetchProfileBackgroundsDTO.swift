//
//  FetchProfileBackgroundsDTO.swift
//  CommonService
//
//  Created by eunseou on 8/6/24.
//

import Foundation

import CommonDomain

public struct FetchProfileBackgroundsResponseDTO: Decodable {
    public let backgrounds: [FetchProfileBackgroundsItemDTO]
}

public struct FetchProfileBackgroundsItemDTO: Decodable {
    public let id: Int
    public let color: String
    public let name: String
}

extension FetchProfileBackgroundsResponseDTO {
    func toDomain() -> FetchProfileBackgroundsResponseEntity {
        return .init(backgrounds: backgrounds.map { $0.toDomain() })
    }
}

extension FetchProfileBackgroundsItemDTO {
    func toDomain() -> FetchProfileBackgroundsItemEntity {
        return .init(id: id, color: color, name: name)
    }
}
