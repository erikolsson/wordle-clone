//
//  AppState.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import ComposableArchitecture

struct AppState: Equatable {
    
    enum GameState: Equatable {
        case playing
        case gameOver(didWin: Bool)
    }
    
    var word: String = Words.randomWord()
    var currentGuess: String = ""
    var guesses: [String] = []
    var gameState: GameState = .playing
    static var gameLanguage: GameLanguage = .english
    
    mutating func reset() {
        gameState = .playing
        word = Words.randomWord()
        guesses.removeAll()
        print(word)
    }
    
    init() {
        reset()
    }
    
}

enum AppAction: Equatable {
    case keyboardInput(KeyboardKey)
    case newGame
    case switchLanguage(GameLanguage)
}

struct AppEnv {}

let appReducer = Reducer<AppState, AppAction, AppEnv> { state, action, env in
    
    switch action {
    case let .keyboardInput(.character(char, _)):
        guard state.gameState == .playing else { return .none }
        if state.currentGuess.count < 5 {
            state.currentGuess += String(char).lowercased()
        }
        return .none
        
    case .keyboardInput(.symbol("delete.left")):
        guard state.gameState == .playing else { return .none }
        _ = state.currentGuess.popLast()
        return .none
        
    case .keyboardInput(.symbol("return.left")):
        guard state.currentGuess.count == 5 else { return .none }
        guard Words.contains(state.currentGuess) else { return .none }
        state.guesses.append(state.currentGuess)
        
        if state.currentGuess == state.word {
            state.gameState = .gameOver(didWin: true)
        } else if state.guesses.count > 5 {
            state.gameState = .gameOver(didWin: false)
        }
        
        state.currentGuess = ""
        return .none
        
    case .newGame:
        state.reset()
        return .none
        
    case .keyboardInput(_):
        return .none
        
    case .switchLanguage(let language):
        guard language != AppState.gameLanguage else { return .none}
        AppState.gameLanguage = language
        state.reset()
        return .none
    }
}

extension AppState {
    
    var boxes: [[LetterBox]] {
        
        var result = guesses.map { str -> [LetterBox] in
            var consumedWord = word
            return zip(str, self.word).map { s1, s2 -> LetterBox in
                
                if s1 == s2 {
                    return .character(s1, color: .green)
                }
                
                if let firstIndex = consumedWord.firstIndex(of: s1) {
                    consumedWord.remove(at: firstIndex)
                    return .character(s1, color: .yellow)
                }
                
                return .character(s1, color: .gray)
            }
        }
        
        if currentGuess.count > 0 {
            let current = currentGuess.map { LetterBox.character($0, color: .black) }
            + Array(repeating: .empty, count: 5 - currentGuess.count)
            result.append(current)
        }
        
        return result + Array(repeating: Array(repeating: LetterBox.empty, count: 5), count: 6 - result.count)
    }
    
    var keyboardKeys: [[KeyboardKey]] {
        
        let highlightedCharacters: Set<Character> = Set(guesses.joined()).intersection(word)
        let dimmedCharacters: Set<Character> = Set(guesses.joined())
        
        let keys = AppState.gameLanguage.keyboardLayout
        
        return keys.map {
            $0.map { key -> KeyboardKey in
                switch key {
                case let .character(char, _) where highlightedCharacters.contains(char):
                    return .character(char, .green)
                case let .character(char, _) where dimmedCharacters.contains(char):
                    return .character(char, .gray)
                default:
                    return key
                }
            }
        }
    }
}
