//
//  MessageRepositoryProtocol.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

import RxSwift

public protocol MessageRepositoryProtocol {
    func fetchMessagesStatus() -> Single<MessageStatusResponseEntity?>
    func fetchReservedMessages() -> Single<ReservedMessageResponseEntity?>
    func fetchMessages(query: MessageRequest) -> Single<ReservedMessageResponseEntity?>
}
