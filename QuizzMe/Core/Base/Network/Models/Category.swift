//
//  Category.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 07.01.2024.
//

import Foundation

struct Category: ButtonPickerItem, Hashable {
    let id: Int
    let name: String
}

extension Category: Decodable {
    
}

struct CategoryHolder {
    let categories: [Category]
}

extension CategoryHolder: Decodable {
    enum CodingKeys: String, CodingKey {
        case categories = "trivia_categories"
    }
}
