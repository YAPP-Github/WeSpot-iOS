//
//  WSNetworkMonitor.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation

import Alamofire

public final class WSNetworkMonitor: EventMonitor {
    
    //MARK: Property
    public var queue: DispatchQueue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "")

    //MARK: Functions
    public func requestDidFinish(_ request: Request) {
        print("⭐️Reqeust WSNetwork LOG⭐️")
        print("URL : \((request.request?.url?.absoluteString ?? ""))")
        print("Method : \((request.request?.httpMethod ?? ""))")
        print("HTTPHeaders \((request.request?.headers) ?? .default):")
        print("Body: \((request.request?.httpBody?.toPrettyPrintedString ?? ""))")
    }
    
    
    public func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("✅Response WSNetwork LOG✅")
        print("URL : \((request.request?.url?.absoluteString ?? ""))")
        print("Results : \((response.result))")
        print("StatusCode : \(response.response?.statusCode ?? 0)")
        print("Data : \(response.data?.toPrettyPrintedString ?? "")")
    }
}
