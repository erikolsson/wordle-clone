//
//  Words.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import Foundation

enum Words {
    
    static func contains(_ string: String) -> Bool {
        return primary.contains(string) || secondary.contains(string)
    }
    
    static func randomWord() -> String {
        return primary.randomElement()!
    }
    
    fileprivate static let primary: Set<String> = {
        return loadWords(from: AppState.gameLanguage.answersFileName)
    }()
    
    fileprivate static let secondary: Set<String> = {
        return loadWords(from: AppState.gameLanguage.allowedGuessesFileName)
    }()
    
    fileprivate static func loadWords(from fileName: String) -> Set<String> {
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let words = data.components(separatedBy: "\n")
                return Set<String>(words)
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
}
