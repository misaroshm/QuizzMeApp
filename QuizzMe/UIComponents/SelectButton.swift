//
//  SelectButton.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 19.12.2023.
//

import SwiftUI

private enum Constants {
    static let cornerRadius = 20.0
    static let frameHeight = 68.0
}

struct SelectButton: View {
    let buttonColor: Color
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .frame(height: Constants.frameHeight)
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
    SelectButton(buttonColor: .titleText, buttonText: "📚 History", action: {})
}
