//
//  ResultViewModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import Foundation
import CoreData

@MainActor
final class ResultViewModel: BaseViewModel {
    let score: Int
    let category: String
    let difficulty: String
    let type: String

    init(score: Int, category: String, difficulty: String, type: String) {
        self.score = score
        self.category = category
        self.difficulty = difficulty
        self.type = type
        super.init()
        saveResult()
    }

    private func saveResult() {
        let context = CoreDataManager.shared.context
        let result = QuizResult(context: context)
        result.date = Date()
        result.score = Int32(score)
        result.category = category
        result.difficulty = difficulty
        result.type = type

        CoreDataManager.shared.saveContext()
    }
}
