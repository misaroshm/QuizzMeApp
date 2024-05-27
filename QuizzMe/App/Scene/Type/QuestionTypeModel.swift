//
//  QuestionTypeModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 25.05.2024.
//

import Foundation

enum QuestionType: String, CaseIterable, ButtonPickerItem {
    case multiple
    case boolean
    
    var name: String {
        switch self {
        case .multiple:
            return "🪐 Multiple choice"
        case .boolean:
            return "🌓 True/False"
            
        }
    }
}
