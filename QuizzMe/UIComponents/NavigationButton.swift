//
//  NavigationButton.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 19.12.2023.
//

import SwiftUI

private enum Constants {
    static let cornerRadius = 20.0
    static let frameHeight = 68.0
}

struct NavigationButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .frame(height: Constants.frameHeight)
                    .foregroundColor(.titleText)
                
                Text(title.uppercased())
                    .font(.button1)
                    .foregroundColor(.white)
            }
        })
    }
}

#Preview {
    NavigationButton(title: "start", action: {})
}
