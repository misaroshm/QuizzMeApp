//
//  Background.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 20.12.2023.
//

import SwiftUI

struct Background<Content: View>: View {
    let content: () -> Content
    let color: Color

    init(with color: Color = .mainBackground, @ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
        self.color = color
    }

    public var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            content()
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            Text("123")
        }
    }
}
