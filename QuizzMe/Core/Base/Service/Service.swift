//
//  Service.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 10.01.2024.
//

import Foundation

enum ResolveType {
    case singleton
    case newSingleton
    case new
}

final class ServiceContainer {
    private static var factories: [ObjectIdentifier: () -> Any] = [:]
    private static var cache: [ObjectIdentifier: Any] = [:]

    static func register<Service>(type: Service.Type, _ factory: @escaping () -> Service) {
        factories[key(for: type.self)] = factory
    }

    static func resolve<Service>(_ resolveType: ResolveType, _ type: Service.Type) -> Service? {
        let key = key(for: type.self)

        switch resolveType {
        case .singleton:
            if let service = cache[key] as? Service {
                return service
            } else {
                guard let service = factories[key]?() as? Service else { return nil }

                cache[key] = service

                return service
            }
        case .newSingleton:
            guard let service = factories[key]?() as? Service else { return nil }

            cache[key] = service
            
            return service
            
        case .new:
            return factories[key]?() as? Service
        }
    }
    
    private static func key<T>(for type: T.Type) -> ObjectIdentifier {
        ObjectIdentifier(type.self)
    }
}

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T
    
    init(resolveType: ResolveType = .new) {
        guard let service = ServiceContainer.resolve(resolveType, T.self) else {
            fatalError("\(String(describing: T.self)) can't be resolved.")
        }
        self.wrappedValue = service
    }
}
