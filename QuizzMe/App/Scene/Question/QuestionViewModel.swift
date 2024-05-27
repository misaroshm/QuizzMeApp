//
//  QuestionViewModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import Foundation
import SwiftUI

@MainActor
final class QuestionViewModel: BaseViewModel {
    let category: Category
    let difficulty: Difficulty
    let type: QuestionType
    
    @Published private var selectedAnswer: String?
    private(set) var didChooseAnswer = false
    
    var isLastQuestion: Bool {
        currentQuestion == quiz.questions.last
    }
    
    @Injected(resolveType: .singleton) private var quizDataProvider: QuizDataProviderProtocol
    @Published var quiz: Quiz = Quiz(questions: [])
    @Published var currentQuestion: QuizQuestion?
    @Published var subheadingText: String = ""
    @Published var score: Int = 0
    
    init(category: Category, difficulty: Difficulty, type: QuestionType) {
        self.category = category
        self.difficulty = difficulty
        self.type = type
    }
    
    func fetchQuiz() async {
        do {
            quiz = try await quizDataProvider.getQuiz(amount: 10, categoryID: category.id, difficulty: difficulty.rawValue, type: type.rawValue)
            currentQuestion = quiz.questions.first
            guard let currentQuestion, let currentQuestionIndex = quiz.questions.firstIndex(of: currentQuestion) else { return }
            subheadingText = "Question \(currentQuestionIndex + 1) of \(quiz.questions.count)"
        } catch {
            self.error = error
        }
    }
    
    func buttonColor(title: String) -> Color {
        guard let currentQuestion, let selectedAnswer else { return .white }
        
        if title == currentQuestion.correctAnswer {
            return .correctAnswer
        } else if selectedAnswer == title {
            return selectedAnswer == currentQuestion.correctAnswer ? .correctAnswer : .wrongAnswer
        } else {
            return .white
        }
    }
    
    func onSelect(answer: String) {
        guard !didChooseAnswer else { return }
        
        selectedAnswer = answer
        didChooseAnswer = true
        
        score += (answer == currentQuestion?.correctAnswer) ? 1 : 0
    }
    
    func onNext(shouldNavigate: (Bool) -> Void ) {
        didChooseAnswer = false
        selectedAnswer = nil
        
        guard let currentQuestion, let nextQuestion = quiz.questions.after(currentQuestion) else {
            shouldNavigate(true)
            return
        }
        
        guard let currentQuestionIndex = quiz.questions.firstIndex(of: nextQuestion) else { return }
        self.currentQuestion = nextQuestion
        subheadingText = "Question \(currentQuestionIndex + 1) of \(quiz.questions.count)"
        shouldNavigate(false)
    }
}
