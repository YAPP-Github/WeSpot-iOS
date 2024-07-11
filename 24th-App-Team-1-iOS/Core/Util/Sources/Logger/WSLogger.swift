//
//  WSLogger.swift
//  Util
//
//  Created by Kim dohyun on 6/27/24.
//

import Foundation
import os.log


/// 기능 단위 로그 타입
public enum Feature: String, CustomStringConvertible {
    public var description: String {
        return "\(self.rawValue.uppercased())"
    }
    case login
}

/// 네트워크 로그 타입
public enum Network: String, CustomStringConvertible{
    public var description: String {
        return "\(self.rawValue.uppercased())"
    }
    
    /// 에러 확인용 로그
    case error
    /// 데이터 출력용 로그
    case `default`
}

public struct WSLogger {
    
    //MARK: Properties
    private static let bundleId: String =  Bundle.main.bundleIdentifier ?? ""
    
    /// 데이터 정보를 확인할떄 사용하는 메서드 입니다.
    /// - Parameters:
    ///   - category: CustomStringConvertible 프로토콜을 준수한 Type이며 해당 파라메터를 통해 작은 영역을 필터링 하도록 함
    ///   - message: 출력 할 Message를 받는 파라메터
    public static func info(category: some CustomStringConvertible, message: String) {
        Logger(subsystem: bundleId, category: category.description)
            .log(level: .info, "\(message)")
    }
    
    /// 코드 디버깅 용도로 사용되는 메서드 입니다.
    /// - Parameters:
    ///   - category: CustomStringConvertible 프로토콜을 준수한 Type이며 해당 파라메터를 통해 작은 영역을 필터링 하도록 함
    ///   - message: 출력 할 Message를 받는 파라메터
    public static func debug(category: some CustomStringConvertible, message: String) {
        Logger(subsystem: bundleId, category: category.description)
            .log(level: .debug, "\(message)")
    }
    
    /// 시스템 또는 앱의 심각한 오류(크래쉬 오류)를 나타낼때 사용하는 메서드 입니다.
    /// - Parameters:
    ///   - category: CustomStringConvertible 프로토콜을 준수한 Type이며 해당 파라메터를 통해 작은 영역을 필터링 하도록 함
    ///   - message: 출력 할 Message를 받는 파라메터
    public static func fault(category: some CustomStringConvertible, message: String) {
        Logger(subsystem: bundleId, category: category.description)
            .log(level: .fault, "\(message)")
    }
    
    /// 오류를 출력할때 사용하는 메서드 입니다.
    /// - Parameters:
    ///   - category: CustomStringConvertible 프로토콜을 준수한 Type이며 해당 파라메터를 통해 작은 영역을 필터링 하도록 함
    ///   - message: 출력 할 Message를 받는 파라메터
    public static func error(category: some CustomStringConvertible, message: String) {
        Logger(subsystem: bundleId, category: category.description)
            .log(level: .error, "\(message)")
    }
    
    /// 일반적인 시스템 작동 중에 정보를 제공하거느 특정 이벤트를 기록하는데 사용되는 메서드 입니다.
    /// - Parameters:
    ///   - cateogry: CustomStringConvertible 프로토콜을 준수한 Type이며 해당 파라메터를 통해 작은 영역을 필터링 하도록 함
    ///   - message: 출력 할 Message를 받는 파라메터
    public static func `default`(cateogry: some CustomStringConvertible, message: String) {
        Logger(subsystem: bundleId, category: cateogry.description)
            .log(level: .default, "\(message)")
    }
}
