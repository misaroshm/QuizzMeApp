//
//  CategoryViewModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import Foundation

@MainActor
final class CategoryViewModel: BaseViewModel {
    @Injected(resolveType: .singleton) private var quizDataProvider: QuizDataProviderProtocol
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?
    
    func fetchCategories() async {
        do {
            categories = try await quizDataProvider.categories.map { categoryData in
                var categoryName = categoryData.name
                for prefix in ["Entertainment:", "Science:"] {
                    categoryName = categoryName.replacingOccurrences(of: prefix, with: "")
                }
                return Category(id: categoryData.id, name: categoryName.name)
            }
        } catch {
            self.error = error
        }
    }
}
