//
//  FetchProfileImagesDTO.swift
//  CommonService
//
//  Created by eunseou on 8/6/24.
//

import Foundation

import CommonDomain

public struct FetchProfileImagesResponseDTO: Decodable {
    public let characters: [FetchProfileImagesItemDTO]
}

public struct FetchProfileImagesItemDTO: Decodable {
    public let id: Int
    public let name: String
    public let iconUrl: String
}

extension FetchProfileImagesResponseDTO {
    func toDomain() -> FetchProfileImageResponseEntity {
        return .init(characters: characters.map { $0.toDomain() })
    }
}

extension FetchProfileImagesItemDTO {
    func toDomain() -> FetchProfileImageItemEntity {
        return .init(id: id, name: name, iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: ""))
    }
}
