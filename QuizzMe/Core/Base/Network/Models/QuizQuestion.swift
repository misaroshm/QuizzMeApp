//
//  QuizQuestion.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 07.01.2024.
//

import Foundation

struct QuizQuestion {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let answers: [String]
}

extension QuizQuestion: Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try container.decode(String.self, forKey: .question).decodedString
        self.correctAnswer = try container.decode(String.self, forKey: .correctAnswer).decodedString
        self.incorrectAnswers = try container.decode([String].self, forKey: .incorrectAnswers).map { $0.decodedString }
        self.answers = (incorrectAnswers + CollectionOfOne(correctAnswer)).shuffled()
    }
}
