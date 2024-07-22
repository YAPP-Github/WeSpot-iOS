//
//  Reactive+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation

import RxSwift

public extension Observable where Element == Data {
    func decodeMap<T: Decodable>(_ type: T.Type) -> Observable<T> {
        flatMap { element -> Observable<T> in
            .create { observer in
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(T.self, from: element)
                    observer.onNext(model)
                } catch {
                    observer.onError(NSError())
                }
                return Disposables.create()
            }
        }
    }
}
