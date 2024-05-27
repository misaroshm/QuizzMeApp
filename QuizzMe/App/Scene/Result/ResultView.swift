//
//  ResultView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import SwiftUI
import CoreData

private enum Constants {
    static let titleText = "congratulations"
    static let subheadingText = "your score is:"
    static let emojiText = "🥳"
    static let buttonText = "play again"
    static let resultText = "Your Results"
    
    static let topPadding = 250.0
    static let buttonHorizontalPadding = 40.0
    static let verticalPadding = 70.0
}

struct ResultView: View {
    @EnvironmentObject var router: Router
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: ResultViewModel
    
    init(score: Int, category: String, difficulty: String, type: String, context: NSManagedObjectContext) {
        self._viewModel = StateObject(wrappedValue: ResultViewModel(score: score, category: category, difficulty: difficulty, type: type))
    }
    
    var body: some View {
        NavigationView {
            BackgroundWithImage {
                VStack {
                    VStack {
                        Text(Constants.titleText.uppercased())
                            .font(.heading3)
                            .foregroundColor(.titleText)
                        Text("\(Constants.subheadingText) \(viewModel.score)")
                            .font(.subheading)
                            .foregroundColor(.mainTextWithOpacity)
                        Text(Constants.emojiText)
                            .font(.heading1)
                    }
                    .padding(.top, Constants.topPadding)
                    
                    Spacer()
                    
                    NavigationButton(title: Constants.buttonText, action: {
                        router.navigateToRoot()
                    })
                    .padding(.horizontal, Constants.buttonHorizontalPadding)
                    
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
        .navigationBarBackButtonHidden()
    }
}
