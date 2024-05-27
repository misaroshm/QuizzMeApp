//
//  ResultsView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 26.05.2024.
//

import SwiftUI
import CoreData

private enum Constants {
    static let cornerRadius = 20.0
    static let frameHeight = 150.0
    static let horrizontalPadding = 15.0
    static let verticalPadding = 5.0
    static let oppacity = 0.5
    
}

struct ResultsView: View {
    @FetchRequest(
        entity: QuizResult.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \QuizResult.date, ascending: false)]
    ) var results: FetchedResults<QuizResult>
    
    var body: some View {
        Background {
            VStack {
                Text("Results")
                    .font(.heading4)
                    .foregroundColor(.titleText)
                    .padding()
                
                ScrollView(showsIndicators: false) {
                    ForEach(results, id: \.self) { result in
                        ResultRow(result: result)
                            .padding(.horizontal, Constants.horrizontalPadding)
                            .padding(.vertical, Constants.verticalPadding)
                    }
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

struct ResultRow: View {
    let result: QuizResult
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.white.opacity(Constants.oppacity))
            .frame(height: Constants.frameHeight)
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Text("Category: \(result.category ?? "")")
                            .font(.rowCategory)
                        Text("Date: \(result.date ?? Date(), formatter: dateFormatter)")
                            .font(.row)
                        Text("Difficulty: \(result.difficulty ?? "")")
                            .font(.row)
                        Text("Type: \(result.type ?? "")")
                            .font(.row)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Score: \(result.score)")
                        .font(.subheadline)
                        .padding()
                }
                    .padding()
            )
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
