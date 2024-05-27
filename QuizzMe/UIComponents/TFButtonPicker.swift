//
//  TFButtonPicker.swift
//  QuizzMe
//
//  Created by Mariia Misarosh on 26.05.2024.
//

import SwiftUI

protocol TFButtonPickerItem {
    var name: String { get }
}

struct TFButtonPicker<Item: ButtonPickerItem, Content: View>: View {
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
    case `true`
    case `false`
    
    var name: String {
        switch self {
        case .true:
            "True"
        case .false:
            "False"
        }
    }
}

#Preview {
    ZStack {
        Background {
            HStack {
                TFButtonPicker(buttons: Item.allCases) { item in
                    TFSelectButton(buttonColor: .white, buttonText: item.name, action: {
                        
                    })
                }
            }
        }
    }
    .ignoresSafeArea()
}
