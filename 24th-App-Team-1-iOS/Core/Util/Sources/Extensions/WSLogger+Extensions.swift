//
//  WSLogger+Extensions.swift
//  Util
//
//  Created by Kim dohyun on 7/23/24.
//

import Foundation

import RxSwift

public extension ObservableType {
    func logErrorIfDetected(category: some CustomStringConvertible) ->Observable<Element> {
        return self.do(onError: { error in
            let errorMessage = error.localizedDescription
            WSLogger.error(category: category, message: errorMessage)
        })
    }
}
