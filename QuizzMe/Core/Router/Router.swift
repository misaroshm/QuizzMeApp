//
//  Router.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 03.01.2024.
//

import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Hashable {
        case start
        case category
        case difficulty(category: Category)
        case type(category: Category, difficulty: Difficulty)
        case request
        case question(category: Category, difficulty: Difficulty, type: QuestionType)
        case result(score: Int, category: String, difficulty: String, type: String)
        case results
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
