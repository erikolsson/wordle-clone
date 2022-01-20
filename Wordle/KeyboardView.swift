//
//  KeyboardView.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI
import ComposableArchitecture

extension KeyboardKey {
  var backgroundColor: Color {
    switch self {
    case .character(_, let keyColor):
      return keyColor.backgroundColor
    case .symbol:
      return KeyColor.normal.backgroundColor
    }
  }
}

extension KeyboardKey.KeyColor {
  var backgroundColor: Color {
    switch self {
    case .normal:
      return .gray
    case .green:
      return .green
    case .gray:
      return Color(white: 0.1)
    }
  }
}

struct KeyboardButton: View {

  let key: KeyboardKey
  var body: some View {
    Group {
      switch key {
      case let .character(character, _):
        Text(String(character).uppercased())
      case .symbol(let string):
        Image(systemName: string)
      }
    }
    .foregroundColor(.white)
    .padding(.vertical)
    .frame(maxWidth: .infinity)
    .background(key.backgroundColor)
    .cornerRadius(4)
  }

}

struct KeyboardView: View {

  let store: Store<AppState, AppAction>
  @ObservedObject var viewStore: ViewStore<AppState, AppAction>
  init(store: Store<AppState, AppAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  var body: some View {
    WithViewStore(store) { viewStore in
      let rows = viewStore.keyboardKeys
      VStack {
        ForEach(0..<rows.count) { row in
          HStack {
            ForEach(0..<rows[row].count) { col in
              Button {
                viewStore.send(.keyboardInput(rows[row][col]))
              } label: {
                KeyboardButton(key: rows[row][col])
              }
            }
          }
        }
      }
    }
    .padding()
  }
}
