//
//  DataProvider.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

protocol DataProvider {
    func perform<T: Decodable>(endPoint: EndPoint) async throws -> T
}

class BaseDataProvider: DataProvider {
    let networkService: NetworkServiceProtocol
    private var requestBuilder: RequestBuilder {
        BaseRequestBuilder(settings: RequestBuilderSettings(baseURL: networkService.networkConfiguration.baseURL, 
                                                            timeoutInterval: networkService.networkConfiguration.timeoutInterval))
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func perform<T>(endPoint: EndPoint) async throws -> T where T: Decodable {
        try await networkService.perform(request: requestBuilder.createRequest(withEndPoint: endPoint))
    }
}
