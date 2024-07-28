//
//  Reactive+Extensions.swift
//  Extensions
//
//  Created by Kim dohyun on 7/23/24.
//

import UIKit
import Networking

import RxSwift
import RxCocoa

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

extension Reactive where Base: UIViewController {
    public var viewWillAppear: ControlEvent<Bool> {
        let event = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: event)
    }
    
    public var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
      }
}

