//
//  MessageRepository.swift
//  MessageService
//
//  Created by eunseou on 8/8/24.
//

import Foundation
import Networking
import MessageDomain
import Util
import Extensions

import RxSwift
import RxCocoa

public final class messageRepository: MessageRepositoryProtocol {
    
    private let networkService: WSNetworkServiceProtocol = WSNetworkService()
    
    public init() { }
    
    public func fetchReservedMessages() -> Single<RecievedMessageResponseEntity?> {
        let endPoint = MessageEndPoint.fetchReservedMessages
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(RecievedMessageResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchMessages(query: MessageRequest) -> Single<ReservedMessageResponseEntity?> {
        let query = MessageRequest(type: query.type, cursorId: query.cursorId)
        let endPoint = MessageEndPoint.fetchMessages(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(RecievedMessageResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
}
