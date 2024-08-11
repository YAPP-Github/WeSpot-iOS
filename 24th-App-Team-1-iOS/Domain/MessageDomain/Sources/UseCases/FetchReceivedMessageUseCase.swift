//
//  FetchReceivedMessageUseCase.swift
//  MessageDomain
//
//  Created by eunseou on 8/9/24.
//

import Foundation

import RxSwift

public protocol FetchReceivedMessageUseCaseProtocol {
    func execute(cursorId: Int) -> Single<ReceivedMessageResponseEntity?>
}

public final class FetchReceivedMessageUseCase: FetchReceivedMessageUseCaseProtocol {
    
    private let repository: MessageRepositoryProtocol
    
    public init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(cursorId: Int) -> Single<ReceivedMessageResponseEntity?> {
        return repository.fetchReceivedMessages(cursorId: cursorId)
    }
}
