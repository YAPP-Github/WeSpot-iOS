//
//  VoteEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import Alamofire


public enum VoteEndPoint: WSNetworkEndPoint {
    /// 질문지 조회 API
    case fetchVoteOptions
    /// 투표 하기 API
    case addVotes(Encodable)
    /// 투표 결과 전체 조회하기
    case fetchResultVotes(Encodable)
    /// 투표 결과 전체 조회하기 (1등)
    case fetchWinnerVotes(Encodable)
    /// 내가 받은 투표 목록 조회
    case fetchReceivedVotes(Encodable)
    /// 내가 받은 투표 개별 조회
    case fetchIndividualVotes
    /// 내가 받은 투표 목록 조회
    case fetchVoteSent(Encodable)
    
    public var path: String {
        switch self {
        case .fetchVoteOptions:
            return "/votes/options"
        case .addVotes:
            return "/votes"
        case .fetchResultVotes:
            return "/votes"
        case .fetchWinnerVotes:
            return "/votes/tops"
        case .fetchReceivedVotes:
            return "/votes/received"
        case .fetchIndividualVotes:
            return "/votes/receive"
        case .fetchVoteSent:
            return "/votes/sent"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchVoteOptions:
            return .get
        case .addVotes:
            return .post
        case .fetchResultVotes:
            return .get
        case .fetchWinnerVotes:
            return .get
        case .fetchReceivedVotes:
            return .get
        case .fetchIndividualVotes:
            return .get
        case .fetchVoteSent:
            return .get
        }
    }
    
    public var parameters: WSRequestParameters {
        switch self {
        case let .fetchWinnerVotes(winnerQuery):
            return .requestQuery(winnerQuery)
        case let .addVotes(body):
            return .requestBody(body)
        case let .fetchResultVotes(allQuery):
            return .requestQuery(allQuery)
        case let .fetchReceivedVotes(receivedQuery):
            return .requestQuery(receivedQuery)
        case let .fetchVoteSent(sentQuery):
            return .requestQuery(sentQuery)
        default:
            return .none
        }
    }
    
    public var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            //TODO: AccessToken 값 넣기
            "Authorization": "Bearer testToken"
        ]
    }
    
}
