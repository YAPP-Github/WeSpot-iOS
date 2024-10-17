//
//  CommonRepository.swift
//  CommonService
//
//  Created by eunseou on 8/4/24.
//

import Foundation
import Networking
import CommonDomain
import Util
import Extensions

import RxSwift
import RxCocoa

public final class CommonRepository: CommonRepositoryProtocol {
    
    
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init() { }
    
    public func fetchUserProfileItems() -> Single<UserProfileEntity?> {
        let endPoint = CommonEndPoint.fetchUserProfile
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(UserProfileResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    
    
    public func updateUserProfileItem(body: UpdateUserProfileRequest) -> Single<Bool> {
        
        let body = UpdateUserProfileRequestDTO(introduction: body.introduction, backgroundColor: body.backgroundColor, iconUrl: body.iconUrl)
        let endPoint = CommonEndPoint.updateUserProfile(body)
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
    public func createCheckProfanity(body: CreateCheckProfanityRequest) -> Single<Bool> {
        let query = CreateCheckProfanityRequestDTO(message: body.message)
        let endPoint = CommonEndPoint.createProfanityCheck(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { data in
                return data.count > 0
            }
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
    public func fetchProfileImages() -> Single<FetchProfileImageResponseEntity?> {
        let endPoint = CommonEndPoint.fetchCharacters
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(FetchProfileImagesResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchProfileBackgrounds() -> Single<FetchProfileBackgroundsResponseEntity?> {
        let endPoint = CommonEndPoint.fetchBackgrounds
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(FetchProfileBackgroundsResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func createReportUserItem(body: CreateUserReportRequest) -> Single<CreateReportUserEntity?> {
        let body = CreateUserReportRequestDTO(reportType: body.type, targetId: body.targetId)
        let endPoint = CommonEndPoint.createUserReport(body)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(CreateReportUserResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchVoteOptions() -> Single<VoteResponseEntity?> {
        let endPoint = CommonEndPoint.fetchVoteOptions
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(VoteResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
}
