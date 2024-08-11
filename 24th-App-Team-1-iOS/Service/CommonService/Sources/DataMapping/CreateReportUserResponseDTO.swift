//
//  CreateReportUserResponseDTO.swift
//  CommonService
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation

import CommonDomain

public struct CreateReportUserResponseDTO: Decodable {
    public let id: Int
}


extension CreateReportUserResponseDTO {
    func toDomain() -> CreateReportUserEntity {
        return .init(id: id)
    }
}
