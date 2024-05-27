//
//  QuizzMeApp.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 14.12.2023.
//

import SwiftUI

@main
struct QuizzMeApp: App {
    @StateObject var router = Router()
    
    init() {
        setupServiceContainer()
        let _ = CoreDataManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                StartView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .start:
                            StartView()
                        case .category:
                            CategoryView(viewModel: CategoryViewModel())
                        case .difficulty(let category):
                            DifficultyView(viewModel: DifficultyViewModel(category: category))
                        case .type(let category, let difficulty):
                            QuestionTypeView(viewModel: QuestionTypeViewModel(category: category, difficulty: difficulty))
                        case .request:
                            RequestView()
                        case .question(let category, let difficulty, let type):
                            if type == .boolean {
                                TFView(viewModel: QuestionViewModel(category: category, difficulty: difficulty, type: type))
                            } else {
                                QuestionView(viewModel: QuestionViewModel(category: category, difficulty: difficulty, type: type))
                            }
                        case .result(let score, let category, let difficulty, let type):
                            ResultView(score: score, category: category, difficulty: difficulty, type: type, context: CoreDataManager.shared.context)
                        case .results:
                            ResultsView()
                        }
                    }
            }
            .environmentObject(router)
            .environment(\.managedObjectContext, CoreDataManager.shared.context)
        }
    }
    
    private func setupServiceContainer() {
        // NetworkService
        ServiceContainer.register(type: NetworkServiceProtocol.self) {
            do {
                let config = try ConfigurationProvider.getConfig()
                let networkConfig = NetworkConfiguration(config: config)
                return NetworkService(networkConfiguration: networkConfig)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        // QuizDataProvider
        ServiceContainer.register(type: QuizDataProviderProtocol.self) {
            QuizDataProvider(networkService: Injected<NetworkServiceProtocol>(resolveType: .singleton).wrappedValue)
        }
    }
}
