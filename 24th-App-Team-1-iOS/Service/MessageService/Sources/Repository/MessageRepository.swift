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
    
    
    public func fetchMessagesStatus() -> Single<MessageStatusResponseEntity?> {
        let endPoint = MessageEndPoint.messagesStatus
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(MessagesStatusResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    
    }
    
    public func fetchReservedMessages() -> Single<ReservedMessageResponseEntity?> {
        let endPoint = MessageEndPoint.fetchReservedMessages
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(ReservedMessageResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
    
    public func fetchReceivedMessages(cursorId: Int) -> Single<ReceivedMessageResponseEntity?> {
        let query = MessageRequest(type: .received, cursorId: cursorId)
        let endPoint = MessageEndPoint.fetchMessages(query)
        
        return networkService.request(endPoint: endPoint)
            .asObservable()
            .logErrorIfDetected(category: Network.error)
            .decodeMap(ReceievedMessageResponseDTO.self)
            .map { $0.toDomain() }
            .asSingle()
    }
}
