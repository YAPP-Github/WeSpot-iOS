//
//  RefreshTokenManager.swift
//  Storage
//
//  Created by eunseou on 8/21/24.
//

import Foundation
import CommonDomain

import RxSwift
import Alamofire
import Util
import CommonService


final class RefreshTokenManager {
    
    static let shared = RefreshTokenManager()
    
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    func refreshToken(completion: @escaping (Result<(String, String), Error>) -> Void) {
        guard let refreshToken = KeychainManager.shared.get(type: .refreshToken) else {
            completion(.failure(WSNetworkError.default(message: "Refresh Token 을 찾을 수 없음")))
            return
        }
        
        let body = CreateRefreshTokenRequest(token: refreshToken)
        let endPoint = CommonEndPoint.createRefreshToken(body)
        
        networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(CreateCommonAccountResponseDTO.self)
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                
                guard let accessToken = entity.accessToken, let newRefreshToken = entity.refreshToken else {
                    completion(.failure(WSNetworkError.default(message: "유효하지 않는 token")))
                    return
                }
                
                KeychainManager.shared.set(value: accessToken, type: .accessToken)
                KeychainManager.shared.set(value: newRefreshToken, type: .refreshToken)
                
                completion(.success((accessToken, newRefreshToken)))
            }, onError: { error in
                completion(.failure(error))
            })
            .disposed(by: disposeBag)
    }
}
