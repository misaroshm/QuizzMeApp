//
//  StartView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 14.12.2023.
//

import SwiftUI

private enum Constants {
    static let imageSize = CGSize(width: 150, height: 150)
    static let title = "QuizzMe"
    static let buttonText = "start"
    static let subtitle = "reveal your knowledge"
    static let resultText = "Your Results"
    static let spacing = 0.0
    static let globalSpacing = 330.0
    static let startButtonHorizontalPadding = 40.0
}

struct StartView: View {
    @StateObject var viewModel = StartViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        BackgroundWithImage {
            VStack(spacing: Constants.globalSpacing) {
                VStack(spacing: Constants.spacing) {
                    Image(.logo)
                        .resizable()
                        .frame(width: Constants.imageSize.width, height: Constants.imageSize.height)
                    
                    Text(Constants.title)
                        .foregroundStyle(.titleText)
                        .font(.heading1)
                    
                    Text(Constants.subtitle)
                        .foregroundStyle(.titleText)
                        .font(.heading2)
                }
                
                VStack {
                    NavigationButton(title: Constants.buttonText) {
                        router.navigate(to: .category)
                    }
                    .padding(.horizontal, Constants.startButtonHorizontalPadding)
                    
                    Button(action: {
                        router.navigate(to: .results)
                    }, label: {
                        Text(Constants.resultText)
                            .foregroundStyle(.titleText)
                            .font(.heading2)
                    })
                }
            }
        }
    }
}

#Preview {
    StartView()
}
