//
//  QuestionTypeViewModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 25.05.2024.
//

import Foundation

@MainActor
final class QuestionTypeViewModel: BaseViewModel {
    let category: Category
    let difficulty: Difficulty
    
    @Published var selectedType: QuestionType?
    
    init(category: Category, difficulty: Difficulty) {
        self.category = category
        self.difficulty = difficulty
    }
}
