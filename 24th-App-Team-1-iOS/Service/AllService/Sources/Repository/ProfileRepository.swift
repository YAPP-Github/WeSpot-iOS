//
//  ProfileRepository.swift
//  AlleService
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation
import Extensions
import Networking
import Util
import AllDomain

import RxSwift
import RxCocoa


public final class ProfileRepository: ProfileRepositoryProtocol {
    
        
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init() { }
 
    public func fetchUserProfileItems() -> Single<UserProfileEntity?> {
        let endPoint = ProfileEndPoint.fetchUserProfile
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(UserProfileResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchUserAlarmItems() -> Single<UserAlarmEntity?> {
        let endPoint = ProfileEndPoint.fetchNotification
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(UserAlarmResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func updateUserAlarmItem(body: UpdateUserProfileAlarmRequest) -> RxSwift.Single<Bool> {
        let body = UpdateUserProfileAlarmRequestDTO(
            isEnableVoteNotification: body.isEnableVoteNotification,
            isEnableMessageNotification: body.isEnableMessageNotification,
            isEnableMarketingNotification: body.isEnableMarketingNotification
        )
        let endPoint = ProfileEndPoint.updateNotification(body)
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
    public func fetchUserBlockItems(query: UserBlockRequestQuery) -> Single<UserBlockEntity?> {
        let query = UserBlockRequestDTO(cursorId: query.cursorId)
        let endPoint = ProfileEndPoint.fetchUserBlock(query)
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .decodeMap(UserBlockResponseDTO.self)
            .logErrorIfDetected(category: Network.error)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func updateUserBlockItem(path: String) -> Single<Bool> {
        let endPoint = ProfileEndPoint.updateUserBlock(path)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
    public func createUserResignItem() -> Single<Bool> {
        let endPoint = ProfileEndPoint.updateUserResign
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .map { _ in true }
            .catchAndReturn(false)
            .logErrorIfDetected(category: Network.error)
            .asSingle()
    }
    
}
