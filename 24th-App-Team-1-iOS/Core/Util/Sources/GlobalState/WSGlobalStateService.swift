//
//  WSGlobalStateService.swift
//  Util
//
//  Created by Kim dohyun on 7/15/24.
//

import Foundation

import RxSwift

public protocol WSGlobalServiceProtocol {
    var event: PublishSubject<WSGlobalStateType> { get }
}

public final class WSGlobalStateService: WSGlobalServiceProtocol {
    public static let shared: WSGlobalServiceProtocol = WSGlobalStateService()
    
    public var event: PublishSubject<WSGlobalStateType> = PublishSubject()
}

public enum WSGlobalStateType {
    case toggleStatus(_ type: VoteTypes)
    case toogleMessageType(_ type: MessageTypes)
}
