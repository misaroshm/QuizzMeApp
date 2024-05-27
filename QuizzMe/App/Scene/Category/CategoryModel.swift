//
//  CategoryModel.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 24.12.2023.
//

import Foundation

struct CategoryModel {
    enum Item: String, Identifiable, CaseIterable, ButtonPickerItem {
        case music
        case sportAndLeisure
        case artsAndLiterature
        case history
        case societyAndCulture
        case science
        case geography
        case foodAndDrink
        case generalKnowledge
        case random
        
        var id: String {
            rawValue
        }
        
        var name: String {
            switch self {
            case .music:
                return "🎶 Music"
            case .sportAndLeisure:
                return "⚽️ Sport and leisure"
            case .artsAndLiterature:
                return "🎨 Arts and literature"
            case .history:
                return "📚 History"
            case .societyAndCulture:
                return "🧕🏻 Society and culture"
            case .science:
                return "🔬 Science"
            case .geography:
                return "✈️ Geography"
            case .foodAndDrink:
                return "🍔 Food and drink"
            case .generalKnowledge:
                return "🌍 General knowledge"
            case .random:
                return "🪐 Random"
            }
        }
    }
}
