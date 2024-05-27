//
//  CategoryView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 19.12.2023.
//

import SwiftUI
import Foundation

private enum Constants {
    static let titleText = "Select the category"
    static let horizontalPadding = 40.0
}

struct CategoryView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: CategoryViewModel
    
    init(viewModel: CategoryViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Background {
                VStack {
                    Text(Constants.titleText)
                        .font(.heading3)
                        .foregroundColor(.titleText)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        ScrollView(showsIndicators: false) {
                            ButtonPicker(buttons: viewModel.categories) { selectedCategory in
                                SelectButton(buttonColor: .white, buttonText: selectedCategory.name) {
                                    router.navigate(to: .difficulty(category: selectedCategory))
                                }
                                .padding(.horizontal, Constants.horizontalPadding)
                            }
                        }
                        .task {
                            await viewModel.fetchCategories()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CategoryView(viewModel: CategoryViewModel())
}
