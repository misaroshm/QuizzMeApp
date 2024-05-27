//
//  DifficultyView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 19.12.2023.
//

import SwiftUI

private enum Constants {
    static let titleText = "Select the difficulty"
    static let verticalPadding = 230.0
    static let horizontalPadding = 40.0
}

struct DifficultyView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: DifficultyViewModel
    
    init(viewModel: DifficultyViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Background {
            VStack {
                Text(Constants.titleText)
                    .font(.heading3)
                    .foregroundColor(.titleText)
                    .multilineTextAlignment(.center)
                
                VStack {
                    ButtonPicker(buttons: Difficulty.allCases) { selectedDifficulty in
                        SelectButton(buttonColor: .white, buttonText: selectedDifficulty.name, action: {
                            router.navigate(to: .type(category: viewModel.category, difficulty: selectedDifficulty))
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
    DifficultyView(viewModel: DifficultyViewModel(category: Category(id: 10, name: "Entertainment: Books")))
}
