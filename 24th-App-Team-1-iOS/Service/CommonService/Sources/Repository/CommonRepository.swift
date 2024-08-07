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
    
    
    public func createCheckProfanity(body: CreateCheckProfanityRequest) -> Single<Bool> {
        let query = CreateCheckProfanityRequestDTO(message: body.message)
        let endPoint = CommonEndPoint.createProfanityCheck(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable() // Observable<Data>
            .map{ _ in  false }
            .catchAndReturn(true)
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
}
