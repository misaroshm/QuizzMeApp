//
//  NetworkService.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    var networkConfiguration: NetworkConfigurationProtocol { get }

    func perform<T>(request: URLRequest) async throws -> T where T: Decodable
}

class NetworkService: NetworkServiceProtocol {
    let networkConfiguration: NetworkConfigurationProtocol
    
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()
    private let session: URLSession
    
    init(session: URLSession = .shared, networkConfiguration: NetworkConfigurationProtocol) {
        self.session = session
        self.networkConfiguration = networkConfiguration
    }
    
    func perform<T>(request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.requestFailed(description: "Invalid Response") }
        
        guard (200..<300) ~= httpResponse.statusCode else { throw ApiError.responseUnsuccessful(description: "Response Status Code: \(httpResponse.statusCode)") }
        
        return try decoder.decode(T.self, from: data)
    }
}
