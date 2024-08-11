//
//  FetchReservedMessageUseCase.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

import RxSwift

public protocol FetchReservedMessageUseCaseProtocol {
    func execute() -> Single<ReservedMessageResponseEntity?>
}

public final class FetchReservedMessageUseCase: FetchReservedMessageUseCaseProtocol {
    
    private let repository: MessageRepositoryProtocol
    
    public init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> Single<ReservedMessageResponseEntity?> {
        return repository.fetchReservedMessages()
    }
}
