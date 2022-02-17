//
//  GameOverView.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI
import ComposableArchitecture

struct GameOverView: View {

  let store: Store<AppState, AppAction>
  @ObservedObject var viewStore: ViewStore<AppState, AppAction>

  init(store: Store<AppState, AppAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  var titleText: String {
    switch viewStore.gameState {
    case let .gameOver(didWin: didWin):
      return didWin ? "Correct!" : "Game Over"
    default:
      return ""
    }
  }

  var body: some View {
    VStack {
      Text(titleText)
        .font(.largeTitle.bold())

      Text(viewStore.word)
        .font(.largeTitle)
      Button("Play Again") {
        viewStore.send(.newGame)
      }.buttonStyle(.borderedProminent)

      Spacer()
    }
    .foregroundColor(.white)
    .padding()
  }
}
