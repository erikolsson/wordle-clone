//
//  GameView.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI
import ComposableArchitecture

struct GameView: View {
  let store: Store<AppState, AppAction>

  var body: some View {
    ZStack {
      Color(white: 0.1)
        .edgesIgnoringSafeArea(.all)

      WithViewStore(store) { viewStore in
        VStack {
          BoardView(store: self.store)
            .layoutPriority(1)
          Spacer()
          switch viewStore.gameState {
          case .playing:
            KeyboardView(store: self.store)

          case .gameOver:
            GameOverView(store: self.store)
          }
        }
      }
    }
  }
}

struct BoardView: View {

  private struct BoxView: View {
    let box: LetterBox

    var body: some View {
      Group {
        switch box {
        case .character(let character, let color):
          color.backgroundColor
            .overlay(
              Text(String(character).uppercased())
                .font(.system(size: 40))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
            )
        case .empty:
          Color.black
        }
      }
      .animation(.linear, value: box)
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: .infinity)
      .cornerRadius(8)
    }
  }

  let store: Store<AppState, AppAction>
  @ObservedObject var viewStore: ViewStore<AppState, AppAction>
  init(store: Store<AppState, AppAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  var body: some View {
    let boxes = viewStore.boxes
    VStack {
      ForEach(0..<boxes.count) { row in
        HStack {
          ForEach(0..<boxes[row].count) { col in
            BoxView(box: boxes[row][col])
          }
        }
      }
    }
    .padding()
  }

}
