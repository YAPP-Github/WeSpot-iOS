//
//  FetchReceivedMessageUseCase.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

import RxSwift

public protocol FetchMessageUseCaseProtocol {
    func execute(query: MessageRequest) -> Single<RecievedMessageResponseEntity?>
}

public final class FetchRecievedMessageUseCase: FetchMessageUseCaseProtocol {
    
    private let repository: MessageRepositoryProtocol
    
    public init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: MessageRequest) -> Single<RecievedMessageResponseEntity?> {
        return repository.fetchMessages(query: query)
    }
}
