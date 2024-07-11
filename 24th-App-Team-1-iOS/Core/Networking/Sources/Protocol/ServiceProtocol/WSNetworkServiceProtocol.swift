//
//  WSNetworkServiceProtocol.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation

import Alamofire
import RxSwift


public protocol WSNetworkServiceProtocol {
    func request<T: Decodable>(endPoint: URLRequestConvertible) -> Single<T>
}
