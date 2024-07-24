//
//  Reactive+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation

import RxSwift
import Networking

extension ObservableType where Element == Data {
    public func decodeMap<T: Decodable>(_ type: T.Type) -> Observable<T> {
        return map { data in
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                throw WSNetworkError.default(message: "Decoding Error")
            }
            return decodedData
        }
    }
}

