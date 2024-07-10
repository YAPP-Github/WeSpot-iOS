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
    
    //MARK: Functions
    public func requset<T: Decodable>(endPoint: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { [weak self] single in
            let task = self?.session.request(endPoint)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(response):
                        single(.success(response))
                    case let .failure(error):
                        switch response.response?.statusCode {
                        case 400:
                            single(.failure(WSNetworkError.badRequest(message: response.request?.url?.absoluteString ?? "")))
                        case 401:
                            single(.failure(WSNetworkError.unauthorized))
                        case 404:
                            single(.failure(WSNetworkError.notFound))
                        default:
                            single(.failure(WSNetworkError.default(message: error.localizedDescription)))
                        }
                    }
                }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
