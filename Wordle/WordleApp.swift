//
//  WordleApp.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI
import ComposableArchitecture

@main
struct WordleApp: App {
  var body: some Scene {
    WindowGroup {
      GameView(store: Store(initialState: AppState(),
                            reducer: appReducer,
                            environment: AppEnv()))
        .preferredColorScheme(.dark)
    }
  }
}
