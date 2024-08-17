//
//  WSNetworkInterceptor.swift
//  Networking
//
//  Created by eunseou on 8/17/24.
//

import Foundation
import CommonDomain
import Storage

import Alamofire
import RxSwift
import RxCocoa

public final class WSNetworkInterceptor: RequestInterceptor {
    
    private let commonRepository: CommonRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    public init(commonRepository: CommonRepositoryProtocol) {
        self.commonRepository = commonRepository
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        
        guard let accessToken = KeychainManager.shared.get(type: .accessToken) else {
            urlRequest.headers.add(name: "Authorization", value: "Bearer testToken")
            completion(.success(urlRequest))
            return
        }
        
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        
        // StatusCode 401의 경우
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(WSNetworkError.default(message: "잘못된 상태코드입니다.")))
            return
        }
        
        guard let refreshToken = KeychainManager.shared.get(type: .refreshToken) else { return }
        let body = CreateRefreshTokenRequest(token: refreshToken)
        
        commonRepository
            .createRefreshToken(body: body)
            .asObservable()
            .subscribe(onNext: {[weak self] entity in
                guard let self = self else { return }
                
                KeychainManager.shared.set(value: entity?.accessToken ?? "", type: .accessToken)
                KeychainManager.shared.set(value: entity?.refreshToken ?? "", type: .refreshToken)
                
                let retry = RetryResult.retry
                completion(retry)
            }, onError: { error in
                completion(.doNotRetryWithError(WSNetworkError.default(message: error.localizedDescription)))
            })
            .disposed(by: disposeBag)
        
    }
}
