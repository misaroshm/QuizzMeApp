//
//  String+HTMLDecodingExtension.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 20.01.2024.
//

import Foundation

extension String {
    var decodedString: String {
        guard let data = data(using: .utf8) else { return self }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            return self
        }
    }
}
