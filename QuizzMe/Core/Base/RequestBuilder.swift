//
//  RequestBuilder.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

protocol RequestBuilder {
    init(settings: RequestBuilderSettings)
    func createRequest(withEndPoint endPoint: EndPoint, cachePolicy: URLRequest.CachePolicy) -> URLRequest
    
}

extension RequestBuilder {
    func createRequest(withEndPoint endPoint: EndPoint, cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) -> URLRequest {
        createRequest(withEndPoint: endPoint, cachePolicy: cachePolicy)
    }
}

struct RequestBuilderSettings {
    let baseURL: URL
    let timeoutInterval: TimeInterval
}

struct BaseRequestBuilder: RequestBuilder {
    private let settings: RequestBuilderSettings
    init(settings: RequestBuilderSettings) {
        self.settings = settings
    }
    
    func createRequest(withEndPoint endPoint: EndPoint, cachePolicy: URLRequest.CachePolicy) -> URLRequest {
        let url = settings.baseURL.appendingPathComponent(endPoint.path)
        let requestCachePolicy = endPoint.httpMethod == .get ? cachePolicy : .reloadIgnoringLocalAndRemoteCacheData
        
        var request = URLRequest(url: url, cachePolicy: requestCachePolicy, timeoutInterval: settings.timeoutInterval)
        setEncodedParameters(request: &request, endPoint: endPoint)
        
        return request
    }
}

private extension BaseRequestBuilder {
    func setEncodedParameters(request: inout URLRequest, endPoint: EndPoint) {
        if let parameters = endPoint.bodyParameters {
            try? endPoint.bodyParameterEncoder.encodeParameters(request: &request, parameters: parameters)
        }
        
        if let parameters = endPoint.headerParameters {
            try? endPoint.headerParameterEncoder.encodeParameters(request: &request, parameters: parameters)
        }
        
        if let parameters = endPoint.queryParameters {
            try? endPoint.queryParameterEncoder.encodeParameters(request: &request, parameters: parameters)
        }
    }
}
