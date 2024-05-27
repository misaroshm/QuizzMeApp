//
//  BackgroundWithImage.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 20.12.2023.
//

import SwiftUI

struct BackgroundWithImage<Content: View>: View {
    let content: () -> Content
    let color: Color
    let image: Image
    
    init(with color: Color = .mainBackground, image: Image = Image(.backgroundCircles), @ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
        self.color = color
        self.image = image
    }
    
    public var body: some View {
        content()
            .background {
                ZStack {
                    color
                        .ignoresSafeArea()
                    image
                        .ignoresSafeArea()
                }
            }
    }
}

struct BackgroundWithImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundWithImage {
            Text("123")
        }
    }
}
