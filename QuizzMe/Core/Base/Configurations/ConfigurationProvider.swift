//
//  ConfigurationProvider.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 07.01.2024.
//

import Foundation

enum ConfigurationProvider {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
    // swiftlint:disable force_cast
    static func getConfig() throws -> [String: String] {
        guard let object = Bundle.main.infoDictionary?["BUILD_CONFIGURATION"] else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as [String: Any]:
            return value.mapValues { $0 as! String }
        default:
            throw Error.invalidValue
        }
    }
    // swiftlint:enable force_cast
}
