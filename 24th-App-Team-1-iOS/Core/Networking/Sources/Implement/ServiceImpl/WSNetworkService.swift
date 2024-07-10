//
//  WSNetworkService.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation

import Alamofire
import RxSwift

public final class WSNetworkService: WSNetworkServiceProtocol {
    
    //MARK: Property
    private let session: Session = {
        let networkMonitor: WSNetworkMonitor = WSNetworkMonitor()
        let networkConfigure: URLSessionConfiguration = URLSessionConfiguration.af.default
        let networkSession: Session = Session(
            configuration: networkConfigure,
            eventMonitors: [networkMonitor]
        )
        return networkSession
    }()
    
    //TODO: Status Code 값에 따른 Network 오류 처리 코드 추가
    public func requset<T: Decodable>(endPoint: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { [weak self] single in
            let task = self?.session.request(endPoint)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(response):
                        single(.success(response))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
