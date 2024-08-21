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
        RefreshTokenManager.shared.refreshToken { result in
            switch result {
            case .success(let (newAccessToken, _)):
                // 토큰 갱신 성공 -> 요청을 재시도
                KeychainManager.shared.set(value: newAccessToken, type: .accessToken)
                completion(.retry)
            case .failure(let error):
                // 토큰 갱신 실패 -> 재시도 X
                completion(.doNotRetryWithError(WSNetworkError.default(message: error.localizedDescription)))
            }
        }
    }
}
