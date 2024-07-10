//
//  WSNetworkEndPoint.swift
//  Networking
//
//  Created by Kim dohyun on 7/10/24.
//

import Foundation

import Alamofire

public protocol WSNetworkEndPoint: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: WSRequestParameters { get }
}


extension WSNetworkEndPoint {
    
    func asURLRequest() throws -> URLRequest {
        var url = try WSNetworkConfigure.baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        switch parameters {
        case let .requestBody(body):
            urlRequest.httpBody = try setupRequestBody(body: body)
        case let .requestQuery(query):
            urlRequest.url = try setupRequestQuery(url, paramters: query)
        case let .reuqestQueryWithBody(query, body: body):
            urlRequest.url = try setupRequestQuery(url, paramters: query)
            urlRequest.httpBody = try setupRequestBody(body: body)
        }
        
        return urlRequest
    }
    
    
    private func setupRequestQuery(_ url: URL, paramters: Encodable?) throws -> URL {
        let params = paramters?.toDictionary() ?? [:]
        let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
        components?.queryItems = queryParams
        guard let originURL = components?.url else {
            throw URLError(.badURL)
        }
        return originURL
    }
    
    private func setupRequestBody(body: Encodable?) throws -> Data {
        let params = body?.toDictionary() ?? [:]
        return try JSONSerialization.data(withJSONObject: params, options: [])
    }
}
