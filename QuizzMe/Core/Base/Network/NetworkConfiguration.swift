//
//  NetworkConfiguration.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

protocol NetworkConfigurationProtocol {
    var baseURL: URL { get }
    var timeoutInterval: TimeInterval { get }
}

private enum NetworkConfigurationKeys {
    static let baseURL = "BASE_URL"
    static let timeoutInterval = "TIMEOUT_INTERVAL"
}

// swiftlint:disable force_unwrapping
final class NetworkConfiguration: NetworkConfigurationProtocol {
    var baseURL: URL {
        let baseUrlString = config[NetworkConfigurationKeys.baseURL]
        return URL(string: "https://\(baseUrlString!)")!
    }
    var timeoutInterval: TimeInterval {
        TimeInterval(config[NetworkConfigurationKeys.timeoutInterval]!)!
    }
    
    private var config: [String: String]
    
    init(config: [String: String]) {
        self.config = config
    }
}
// swiftlint:enable force_unwrapping
