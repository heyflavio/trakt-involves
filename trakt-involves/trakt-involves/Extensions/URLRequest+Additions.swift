//
//  URLRequest+Additions.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

enum URLRequestMethod: String {
    case post = "POST"
    case get = "GET"
}

extension URLRequest {
    
    static let contentType = "Content-Type"
    static let jsonHeader = "application/json"
    static let authorization = "Authorization"
    static let tokenHeader = "Token \("TOKEN")"
    
    static func getURLRequest<T>(with url: URL, body: T, andMethod method: URLRequestMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(jsonHeader, forHTTPHeaderField: contentType)
        urlRequest.setValue(tokenHeader, forHTTPHeaderField: authorization)
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        return urlRequest
    }
}
