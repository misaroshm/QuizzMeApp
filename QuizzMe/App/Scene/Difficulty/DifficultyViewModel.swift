//
//  DifficultyViewModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import Foundation

@MainActor
final class DifficultyViewModel: BaseViewModel {
    let category: Category
    @Published var difficulty: [Difficulty] = []
    @Published var selectedDifficulty: Difficulty?
    
    init(category: Category) {
        self.category = category
    }
}
