//
//  QuestionTypeView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 25.05.2024.
//

import SwiftUI

private enum Constants {
    static let titleText = "Select the type of quiz"
    static let verticalPadding = 230.0
    static let horizontalPadding = 40.0
}

struct QuestionTypeView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: QuestionTypeViewModel
    
    init(viewModel: QuestionTypeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Background {
            VStack {
                Text(Constants.titleText)
                    .font(.heading4)
                    .foregroundColor(.titleText)
                    .multilineTextAlignment(.center)
                
                VStack {
                    ButtonPicker(buttons: QuestionType.allCases) { selectedType in
                        SelectButton(buttonColor: .white, buttonText: selectedType.name, action: {
                            viewModel.selectedType = selectedType
                            router.navigate(to: .question(category: viewModel.category, difficulty: viewModel.difficulty, type: selectedType))
                        })
                        .padding(.horizontal, Constants.horizontalPadding)
                    }
                }
            }
            .padding(.vertical, Constants.verticalPadding)
        }
    }
}

#Preview {
    QuestionTypeView(viewModel: QuestionTypeViewModel(category: Category(id: 10, name: "Entertainment: Books"), difficulty: .easy))
}
