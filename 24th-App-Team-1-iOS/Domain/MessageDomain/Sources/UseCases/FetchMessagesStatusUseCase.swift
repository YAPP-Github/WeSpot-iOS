//
//  FetchMessagesStatusUseCase.swift
//  MessageDomain
//
//  Created by eunseou on 8/9/24.
//

import Foundation

import RxSwift

public protocol FetchMessagesStatusUseCaseProtocol {
    func execute() -> Single<MessageStatusResponseEntity?>
}

public final class FetchMessagesStatusUseCase: FetchMessagesStatusUseCaseProtocol {
    
    private let repository: MessageRepositoryProtocol
    
    public init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Single<MessageStatusResponseEntity?> {
        return repository.fetchMessagesStatus()
    }
}
