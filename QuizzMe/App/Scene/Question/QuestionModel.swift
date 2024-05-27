//
//  QuestionModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 27.12.2023.
//

import Foundation

struct QuestionModel {
    enum Item: String, Identifiable, CaseIterable, ButtonPickerItem {
        case option1
        case option2
        case option3
        case option4
        
        var id: String {
            rawValue
        }
        
        var name: String {
            switch self {
            case .option1:
                return "Lviv"
            case .option2:
                return "Kyiv"
            case .option3:
                return  "Kharkiv"
            case .option4:
                return "Odesa"
            }
        }
    }
}
