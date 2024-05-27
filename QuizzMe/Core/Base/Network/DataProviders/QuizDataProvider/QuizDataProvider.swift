//
//  QuizDataProvider.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 07.01.2024.
//

import Foundation

protocol QuizDataProviderProtocol {
    var categories: [Category] { get async throws }
    
    func getQuiz(amount: Int, categoryID: Int, difficulty: String, type: String) async throws -> Quiz
}

final class QuizDataProvider: BaseDataProvider, QuizDataProviderProtocol {
    var categories: [Category] {
        get async throws {
            let categoryHolder: CategoryHolder = try await perform(endPoint: QuizEndPoint.getCategories)
            return categoryHolder.categories
        }
    }
    
    func getQuiz(amount: Int, categoryID: Int, difficulty: String, type: String) async throws -> Quiz {
        let endPoint = QuizEndPoint.getQuiz(amount: amount, categoryID: categoryID, difficulty: difficulty, type: type)
        return try await perform(endPoint: endPoint)
    }
}
