//
//  RequestView.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 27.12.2023.
//

import SwiftUI

private enum Constants {
    static let text = "Requesting Questions..."
}

struct RequestView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        Background {
            VStack {
                Text(Constants.text)
                    .font(.button2)
                    .foregroundColor(.mainText)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RequestView()
}
