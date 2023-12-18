//
//  Word.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

struct Word: Codable, Identifiable {
    private enum CodingKeys : String, CodingKey {
        case original, base, declension, type, gender, translations
    }
    
    var original: String
    var base: String?
    let declension: String?
    let type: WordType
    let gender: Gender?
    let translations: [Translation]
    
    var id = UUID()
    
    
    func shouldShowNumber(number: Number) -> Bool {
        switch number {
        case .singular:
            return true
        case .dual:
            return false
        case .plural:
            return true
        }
    }
    
    func shouldShowGender(number: Number, gen: Gender) -> Bool {
        if type == .noun {
            if gender != nil {
                if gender == gen {
                    return true
                } else {
                    return false
                }
            } else {
                if gen == .masculine {
                    return true
                } else {
                    return false
                }
            }
        }
        
        return false
    }
    
    func countGenders(for number: Number) -> Int {
        if type == .noun {
            return 1
        }
        
        return 1
    }
    
    func generateCase(wordCase: Case, number: Number, gender: Gender) -> String? {
        switch wordCase {
        case .nominative:
            return generateNominative(number: number, gender: gender)
        case .vocative:
            return generateVocative(number: number, gender: gender)
        case .accusative:
            return generateAccusative(number: number, gender: gender)
        case .genitive:
            return generateGenitive(number: number, gender: gender)
        case .dative:
            return generateDative(number: number, gender: gender)
        case .instrumental:
            return generateInstrumental(number: number, gender: gender)
        }
    }
    
    func generateNominative(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return original
        case .dual, .plural:
            return base! + "ōz"
        }
    }
    
    func generateVocative(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return base
        case .dual, .plural:
            return base! + "ōz"
        }
    }
    
    func generateAccusative(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return base! + "ą"
        case .dual, .plural:
            return base! + "anz"
        }
    }
    
    func generateGenitive(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return base! + "as"
        case .dual, .plural:
            return base! + "ǒ"
        }
    }
    
    func generateDative(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return base! + "ai"
        case .dual, .plural:
            return base! + "amaz"
        }
    }
    
    func generateInstrumental(number: Number, gender: Gender) -> String? {
        switch number {
        case .singular:
            return base! + "ō"
        case .dual, .plural:
            return base! + "amiz"
        }
    }
}
