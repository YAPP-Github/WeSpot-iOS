//
//  MessageRepositoryProtocol.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

import RxSwift

public protocol MessageRepositoryProtocol {
    func fetchReservedMessages() -> Single<RecievedMessageResponseEntity?>
    func fetchMessages(query: MessageRequest) -> Single<RecievedMessageResponseEntity?>
}
