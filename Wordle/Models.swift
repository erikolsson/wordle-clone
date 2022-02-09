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
