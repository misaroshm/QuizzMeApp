//
//  Quiz.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 07.01.2024.
//

import Foundation

struct Quiz {
    let questions: [QuizQuestion]
}

extension Quiz: Decodable {
    enum CodingKeys: String, CodingKey {
        case questions = "results"
    }
}
