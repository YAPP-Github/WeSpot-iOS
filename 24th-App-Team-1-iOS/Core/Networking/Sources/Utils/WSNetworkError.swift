//
//  WSNetworkError.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation


public enum WSNetworkError: Error, LocalizedError {
    case `default`(statusCode: Int)
    case badRequest(message: String)
    case unauthorized
    case forbidden
    case notFound
    case conflict
    case internalServerError
    
    public var errorDescription: String? {
        switch self {
        case let .badRequest(message):
            return "잘못된 서버 요청으로 인한 오류가 발생하였습니다. 원인 ➡️: \(message)"
        case .unauthorized:
            return "인증 토큰이 만료되었습니다."
        case .forbidden:
            return "현재 클라이언트가 권한이 없습니다."
        case .notFound:
            return "요청한 리소스를 찾을 수 없습니다."
        case .conflict:
            return "요청한 서버가 충돌이 발생하였습니다."
        case .internalServerError:
            return "요청한 서버에서 문제가 발생했습니다"
        case let .default(statusCode):
            return "요청한 서버의 응값 값은 : \(statusCode)"
        }
    }
}
