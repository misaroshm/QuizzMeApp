//
//  EndPoint.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndPoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headerParameters: [String: Any?]? { get }
    var bodyParameters: [String: Any?]? { get }
    var queryParameters: [String: Any?]? { get }

    var headerParameterEncoder: ParameterEncoder { get }
    var bodyParameterEncoder: ParameterEncoder { get }
    var queryParameterEncoder: ParameterEncoder { get }
}

extension EndPoint {
    var headerParameters: [String: Any?]? { nil }
    var bodyParameters: [String: Any?]? { nil }
    var queryParameters: [String: Any?]? { nil }
    
    var headerParameterEncoder: ParameterEncoder { HeaderParameterEncoder() }
    var bodyParameterEncoder: ParameterEncoder { JSONParameterEncoder() }
    var queryParameterEncoder: ParameterEncoder { QueryParameterEncoder() }
}

protocol ParameterEncoder {
    func encodeParameters(request: inout URLRequest, parameters: [String: Any?]) throws
}

struct JSONParameterEncoder: ParameterEncoder {
    func encodeParameters(request: inout URLRequest, parameters: [String: Any?]) throws {
        let compactParameters = parameters.compactMap { (key, value) -> (String, Any)? in
            guard let value else { return nil }
            return (key, value)
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: Dictionary(uniqueKeysWithValues: compactParameters), options: [.prettyPrinted, .fragmentsAllowed])
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

struct HeaderParameterEncoder: ParameterEncoder {
    func encodeParameters(request: inout URLRequest, parameters: [String: Any?]) throws {
        let compactParameters = parameters.compactMap { (key, value) -> (String, String)? in
            guard let value = value as? String else { return nil }
            return (key, value)
        }
        
        compactParameters.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

struct QueryParameterEncoder: ParameterEncoder {
    func encodeParameters(request: inout URLRequest, parameters: [String: Any?]) throws {
        let compactParameters = parameters.compactMap { (key, value) -> URLQueryItem? in
            guard let value = value as? String else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        
        guard let url = request.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        urlComponents.queryItems = compactParameters
        
        guard let newURL = urlComponents.url else { return }
        request = URLRequest(url: newURL, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
    }
}
