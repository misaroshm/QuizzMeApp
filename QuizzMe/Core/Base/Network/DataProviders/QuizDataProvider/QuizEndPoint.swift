//
//  QuizEndPoint.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import Foundation

enum QuizEndPoint: EndPoint {
    case getCategories
    case getQuiz(amount: Int, categoryID: Int, difficulty: String, type: String)
    
    var path: String {
        switch self {
        case .getCategories:
            return "/api_category.php"
        case .getQuiz:
            return "/api.php"
        }
    }
    
    var queryParameters: [String: Any?]? {
        switch self {
        case .getCategories:
            return nil
        case .getQuiz(let amount, let categoryID, let difficulty, let type):
            return ["amount": "\(amount)", "category": "\(categoryID)", "difficulty": "\(difficulty)", "type": "\(type)"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCategories, .getQuiz:
            return .get
        }
    }
}
