//
//  TFSelectButton.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 26.05.2024.
//

import SwiftUI

private enum Constants {
    static let cornerRadius = 20.0
    static let frameHeight = 265.0
    static let frameWidth = 175.0
}

struct TFSelectButton: View {
    let buttonColor: Color
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .frame(width: Constants.frameWidth, height: Constants.frameHeight)
                    .foregroundColor(buttonColor)
                
                Text(buttonText)
                    .font(.button2)
                    .foregroundColor(.mainText)
                    .padding(.horizontal)
            }
        })
    }
}

#Preview {
    TFSelectButton(buttonColor: .titleText, buttonText: "📚 History", action: {})
}
