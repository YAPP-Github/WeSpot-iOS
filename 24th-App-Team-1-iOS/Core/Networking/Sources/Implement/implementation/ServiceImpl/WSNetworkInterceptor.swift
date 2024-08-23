//
//  WSNetworkInterceptor.swift
//  Networking
//
//  Created by eunseou on 8/17/24.
//

import Foundation
import Storage
import Util

import Alamofire
import RxSwift
import RxCocoa

public final class WSNetworkInterceptor: RequestInterceptor {

    private var retryLimit = 2
    private let disposeBag = DisposeBag()
    
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
        
        let refreshToken = KeychainManager.shared.get(type: .refreshToken)
        
        guard let statusCode = request.response?.statusCode,
              request.retryCount < retryLimit else { return completion(.doNotRetry) }
        
        if request.retryCount < retryLimit {
            if statusCode == 401  {
                guard let refreshToken = KeychainManager.shared.get(type: .refreshToken) else { 
                    return completion(.doNotRetryWithError(WSNetworkError.default(message: "리프레쉬 토큰을 찾을 수 없습니다.")))
                }
                
                let body = ReissueToken(token: refreshToken)
                let endPoint = ReissueEndPoint.createReissueToken(body: body)
                WSNetworkService().request(endPoint: endPoint)
                    .asObservable()
                    .decodeMap(AccessToken.self)
                    .logErrorIfDetected(category: Network.error)
                    .subscribe { token in
                        KeychainManager.shared.set(value: token.accessToken, type: .accessToken)
                        KeychainManager.shared.set(value: token.refreshToken, type: .refreshToken)
                    } onError: { error in
                        completion(.doNotRetryWithError(error))
                    }
                    .disposed(by: disposeBag)



                
            }
        }
    }
}
