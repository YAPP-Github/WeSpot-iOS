//
//  WSNetworkMonitor.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation

import Alamofire
import Util

public final class WSNetworkMonitor: EventMonitor {
    
    //MARK: Property
    public var queue: DispatchQueue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "")

    //MARK: Functions
    public func requestDidFinish(_ request: Request) {
        WSLogger.debug(category: Network.default, message: "⭐️Reqeust WSNetwork LOG⭐️")
        WSLogger.debug(category: Network.default, message: "URL : \((request.request?.url?.absoluteString ?? ""))")
        WSLogger.debug(category: Network.default, message: "Method : \((request.request?.httpMethod ?? ""))")
        WSLogger.debug(category: Network.default, message: "HTTPHeaders \((request.request?.headers) ?? .default):")
        
    }
    
    
    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        WSLogger.debug(category: Network.default, message: "✅Response WSNetwork LOG✅")
        WSLogger.debug(category: Network.default, message: "URL : \((request.request?.url?.absoluteString ?? ""))")
        WSLogger.debug(category: Network.default, message: "Results : \((response.result))")
        WSLogger.debug(category: Network.default, message: "StatusCode : \(response.response?.statusCode ?? 0)")
        WSLogger.debug(category: Network.default, message: "Data : \(response.data?.toPrettyPrintedString ?? "")")
    }
}
