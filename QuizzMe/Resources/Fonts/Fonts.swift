//
//  Fonts.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 20.12.2023.
//

import SwiftUI

enum Fonts: String {
    case poppinsMedium = "Poppins-Medium"
    case poppinsBold = "Poppins-Bold"
    case titanOneRegular = "Titan One"
    case changoRegular = "Chango-Regular"
}

extension Font {
    static let heading1 = customFont(Fonts.changoRegular.rawValue, 60)
    static let heading2 = customFont(Fonts.titanOneRegular.rawValue, 20)
    static let heading3 = customFont(Fonts.titanOneRegular.rawValue, 33)
    static let heading4 = customFont(Fonts.titanOneRegular.rawValue, 30)
    
    static let subheading = customFont(Fonts.poppinsMedium.rawValue, 20)
    
    static let button1 = customFont(Fonts.poppinsBold.rawValue, 16)
    static let button2 = customFont(Fonts.poppinsMedium.rawValue, 24)
    static let row = customFont(Fonts.poppinsMedium.rawValue, 15)
    static let rowCategory = customFont(Fonts.poppinsMedium.rawValue, 20)
    
    static func customFont(_ name: String, _ fixedSize: CGFloat) -> Font {
        .monospacedDigit(.custom(name, fixedSize: fixedSize))()
    }
}
