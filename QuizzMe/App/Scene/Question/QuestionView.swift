//
//  QuestionView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 23.12.2023.
//

import SwiftUI

private enum Constants {
    static let buttonText = "Next Question"
    static let buttonTextResult = "See Results"
    static let alertTitle = "No Questions"
    static let alertMessage = "There are no questions available for this category. Please choose another category."
    static let alertDismissButtonText = "OK"
    static let buttonsName = ["True", "False"]
    
    static let spacing = 15.0
    static let buttonHorizontalPadding = 40.0
    static let topPadding = 80.0
    static let leadingPadding = 50.0
    static let minimumScaleFactor = 0.5
}

struct QuestionView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: QuestionViewModel
    @State private var isFetchingQuiz = true
    @State private var showAlert = false
    
    init(viewModel: QuestionViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if isFetchingQuiz {
            RequestView()
                .task {
                    await viewModel.fetchQuiz()
                    isFetchingQuiz = false
                    showAlert = viewModel.quiz.questions.isEmpty
                }
        } else {
            NavigationView {
                Background {
                    VStack {
                        Spacer()
                        Text(viewModel.currentQuestion?.question ?? "")
                            .font(.heading3)
                            .minimumScaleFactor(Constants.minimumScaleFactor)
                            .foregroundColor(.titleText)
                            .multilineTextAlignment(.center)
                        
                        VStack {
                            HStack {
                                Text(viewModel.subheadingText)
                                    .font(.subheading)
                                    .foregroundColor(.mainTextWithOpacity)
                                Spacer()
                            }
                            .padding(.leading, Constants.leadingPadding)
                            
                            VStack(spacing: Constants.spacing) {
                                if viewModel.type == .multiple {
                                    ButtonPicker(buttons: viewModel.currentQuestion?.answers ?? [""]) { selectedAnswer in
                                        SelectButton(buttonColor: viewModel.buttonColor(title: selectedAnswer), buttonText: selectedAnswer, action: {
                                            viewModel.onSelect(answer: selectedAnswer)
                                        })
                                        .padding(.horizontal, Constants.buttonHorizontalPadding)
                                        .minimumScaleFactor(Constants.minimumScaleFactor)
                                    }
                                } else {
                                    ButtonPicker(buttons: Constants.buttonsName) { selectedAnswer in
                                        SelectButton(buttonColor: viewModel.buttonColor(title: selectedAnswer), buttonText: selectedAnswer, action: {
                                            viewModel.onSelect(answer: selectedAnswer)
                                        })
                                        .padding(.horizontal, Constants.buttonHorizontalPadding)
                                        .minimumScaleFactor(Constants.minimumScaleFactor)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, Constants.topPadding)
                        NavigationButton(title: viewModel.isLastQuestion ? Constants.buttonTextResult : Constants.buttonText) {
                            withAnimation(.spring()) {
                                viewModel.onNext { shouldNavigate in
                                    guard shouldNavigate else { return }
                                    router.navigate(to: .result(
                                        score: viewModel.score,
                                        category: viewModel.category.name,
                                        difficulty: viewModel.difficulty.name,
                                        type: viewModel.type.name
                                    ))
                                }
                            }
                        }
                        .disabled(!viewModel.didChooseAnswer)
                        .padding(.horizontal, Constants.buttonHorizontalPadding)
                        Spacer()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Constants.alertTitle),
                    message: Text(Constants.alertMessage),
                    dismissButton: .default(Text(Constants.alertDismissButtonText)) {
                        router.navigate(to: .category)
                    }
                )
            }
        }
    }
}

#Preview {
    QuestionView(viewModel: QuestionViewModel(category: Category(id: 10, name: "book"), difficulty: Difficulty.easy, type: QuestionType.multiple))
}
