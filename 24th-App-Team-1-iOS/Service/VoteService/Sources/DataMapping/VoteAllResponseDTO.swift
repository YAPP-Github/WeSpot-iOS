//
//  VoteAllResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation

import VoteDomain


public struct VoteAllResponseDTO: Decodable {
    public let response: [VoteAllItemReponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteResults"
    }
}

extension VoteAllResponseDTO {
    public struct VoteAllItemReponseDTO: Decodable {
        public let options: VoteAllOptionsDTO
        public let results: [VoteAllResultsDTO]
        
        private enum CodingKeys: String, CodingKey {
            case options = "voteOption"
            case results
        }
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO {
    public struct VoteAllOptionsDTO: Decodable {
        public let id: Int
        public let content: String
        
    }
    
    public struct VoteAllResultsDTO: Decodable {
        public let user: VoteAllUserResponseDTO
        public let voteCount: Int
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO {
    public struct VoteAllUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let introduction: String
        public let profileInfo: VoteAllProfileResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name, introduction
            case profileInfo = "profile"
        }
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO {
    public struct VoteAllProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension VoteAllResponseDTO {
    func toDomain() -> VoteAllReponseEntity {
        return .init(response: response.map { $0.toDomain()} )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO {
    func toDomain() -> VoteAllEntity {
        
        var transformResults: [VoteAllResultEntity] = results.map { $0.toDomain() }
        
        if results.isEmpty {
            return .init(
                options: options.toDomain(),
                results: results.map { $0.toDomain() }
            )
        }
        
        var transformMockName:[String] = ["김도현", "박주현", "이지호", "김선희", "정진호"]
        let transformAllEntity: [VoteAllResultEntity] = (1...(5 - transformResults.count)).map { index in
            return .init(
                user: VoteAllUserEntity(
                    id: index,
                    name: transformMockName[index - 1],
                    introduction: "안녕하세요 저는 \(transformMockName[index - 1])이에요",
                    profile: VoteAllProfileEntity(
                        backgroundColor: "",
                        iconUrl: URL(fileURLWithPath: "")
                    )
                ),
                voteCount: 0
            )
        }
        
        transformResults.append(contentsOf: transformAllEntity)
        
        return .init(
            options: options.toDomain(),
            results: transformResults
        )
    }
}


extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllOptionsDTO {
    func toDomain() -> VoteAllOptionsEntity {
        return .init(
            id: id,
            content: content
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO {
    func toDomain() -> VoteAllResultEntity {
        return .init(
            user: user.toDomain(),
            voteCount: voteCount
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO {
    func toDomain() -> VoteAllUserEntity {
        return .init(
            id: id,
            name: name,
            introduction: introduction,
            profile: profileInfo.toDomain()
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO.VoteAllProfileResponseDTO {
    func toDomain() -> VoteAllProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
