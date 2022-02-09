//
//  Models.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI

enum GameLanguage {
    case english
    case french
    
    var answersFileName: String {
        switch self {
        case .english:
            return "wordle-answers-alphabetical_en"
        case .french:
            return "wordle-answers-alphabetical_fr"
        }
    }
    
    var allowedGuessesFileName: String {
        switch self {
        case .english:
            return "wordle-allowed-guesses_en"
        case .french:
            return "wordle-allowed-guesses_fr"
        }
    }
    
    var keyboardLayout: [[KeyboardKey]] {
        switch self {
        case .english:
            return [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                [.symbol("return.left"), "z", "x", "c", "v", "b", "n", "m", .symbol("delete.left")],
            ]

        case .french:
            return [
                ["a", "z", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["q", "s", "d", "f", "g", "h", "j", "k", "l", "m"],
                [.symbol("return.left"), "w", "x", "c", "v", "b", "n", .symbol("delete.left")],
            ]
        }
    }
}


enum LetterBox: Equatable {

  enum LetterBoxColor: Equatable {
    case black
    case gray
    case yellow
    case green

    var backgroundColor: Color {
      switch self {
      case .black:
        return .black
      case .yellow:
        return .yellow
      case .green:
        return .green
      case .gray:
        return .gray
      }
    }
  }

  case character(Character, color: LetterBoxColor)
  case empty

}

public enum KeyboardKey: Equatable, ExpressibleByExtendedGraphemeClusterLiteral {
  public typealias ExtendedGraphemeClusterLiteralType = Character

  public enum KeyColor: Equatable {
    case normal
    case green
    case gray
  }

  case character(Character, KeyColor)
  case symbol(String)

  public init(extendedGraphemeClusterLiteral value: Character) {
    self = .character(value, .normal)
  }
}
