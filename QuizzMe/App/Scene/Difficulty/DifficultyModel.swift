//
//  DifficultyModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 27.12.2023.
//

import Foundation

enum Difficulty: String, Identifiable, CaseIterable, ButtonPickerItem {
    case easy
    case medium
    case hard
    
    var id: String {
        rawValue
    }
    
    var name: String {
        switch self {
        case .easy:
            return "😀 Easy"
        case .medium:
            return "😐 Medium"
        case .hard:
            return  "😰 Hard"
        }
    }
}
