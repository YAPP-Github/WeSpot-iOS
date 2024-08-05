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
}
