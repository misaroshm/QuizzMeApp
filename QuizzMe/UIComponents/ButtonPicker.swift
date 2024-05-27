//
//  ButtonPicker.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 24.12.2023.
//

import SwiftUI

protocol ButtonPickerItem {
    var name: String { get }
}

struct ButtonPicker<Item: ButtonPickerItem, Content: View>: View {
    private let content: (_ item: Item) -> Content
    private let buttons: [Item]
    
    init(buttons: [Item], content: @escaping (_ item: Item) -> Content) {
        self.content = content
        self.buttons = buttons
    }
    
    var body: some View {
        ForEach(buttons, id: \.name) { item in
            content(item)
        }
    }
}

private enum Item: String, CaseIterable, ButtonPickerItem {
    case one
    case two
    case three
    
    var name: String {
        rawValue
    }
}

#Preview {
    ZStack {
        Background {
            VStack {
                ButtonPicker(buttons: Item.allCases) { item in
                    SelectButton(buttonColor: .white, buttonText: item.name, action: {
                        
                    })
                    .padding(.horizontal, 40)
                }
            }
        }
    }
    .ignoresSafeArea()
}
