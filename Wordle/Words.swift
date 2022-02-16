//
//  Words.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import Foundation

enum Words {
  static func contains(_ string: String, in language: GameLanguage) -> Bool {
    return answers(in: language).contains(string) || allowedGuesses(in: language).contains(string)
  }

  static func randomWord(in language: GameLanguage) -> String {
    return answers(in: language).randomElement()!
  }

  fileprivate static func answers(in language: GameLanguage) -> Set<String> {
    return loadWords(from: language.answersFileName)
  }

  fileprivate static func allowedGuesses(in language: GameLanguage) -> Set<String> {
    return loadWords(from: language.allowedGuessesFileName)
  }

  fileprivate static func loadWords(from fileName: String) -> Set<String> {
    do {
      if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        let words = data.components(separatedBy: "\n").map { $0.folding(options: .diacriticInsensitive, locale: .current)}
        return Set<String>(words)
      }
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}
