//
//  Word.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

struct Word: Codable, Identifiable {
    private enum CodingKeys : String, CodingKey {
        case original, base, declension, type, gender, translations, verb
    }
    
    var original: String
    var base: String?
    let declension: String?
    let type: WordType
    let gender: Gender?
    let translations: [Translation]
    
    let verb: Verb?
    
    var id = UUID()
    
    
    func shouldShowMood(tense: Tense, mood: Mood) -> Bool {
        if mood == .imperative && tense == .past {
            return false
        }
        return true
    }
    
    
    
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
    
    func generateConjugation(person: Person, number: Number, tense: Tense, mood: Mood) -> String? {
        switch tense {
        case .past:
            switch mood {
            case .indicative:
                return generateConjugationPastIndicative(person: person, number: number)
            case .subjunctive:
                return generateConjugationPastSubjunctive(person: person, number: number)
            case .imperative:
                return "-"
            }
        case .present:
            switch mood {
            case .indicative:
                return generateConjugationPresentIndicative(person: person, number: number)
            case .subjunctive:
                return generateConjugationPresentSubjunctive(person: person, number: number)
            case .imperative:
                return generateConjugationPresentImperative(person: person, number: number)
            }
        }
    }
    
    func generateConjugationPastIndicative(person: Person, number: Number) -> String? {
        var word = original
        

        if number == .singular {
            if let verbSecond = verb?.forms.second {
                word = verbSecond
            }
        } else {
            if let verbThird = verb?.forms.third {
                word = verbThird
            }
        }
        
        switch person {
        case .first:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.first {
                    return form
                } else {
//                    word += "ō"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.first {
                    return form
                } else {
                    word.removeLast(2)
                    word += "ū"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.first {
                    return form
                } else {
                    word.removeLast()
                    word += "m"
                }
            }
        case .second:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "st"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "diz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "d"
                }
            }
        case .third:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.third {
                    return form
                } else {
//                    word += "idi"
                }
            case .dual:
                return "-"
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.third {
                    return form
                } else {
                    word.removeLast()
                    word += "n"
                }
            }
        }
        
        return word
    }
    
    func generateConjugationPastSubjunctive(person: Person, number: Number) -> String? {
        var word = original
        
        if let verbThird = verb?.forms.third {
            word = verbThird
            word.removeLast()
        }
        
        switch person {
        case .first:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.first {
                    return form
                } else {
                    word.removeLast()
                    word += "į̄"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.first {
                    return form
                } else {
                    word.removeLast()
                    word += "īw"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.first {
                    return form
                } else {
                    word.removeLast()
                    word += "īm"
                }
            }
        case .second:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "īz"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "īdiz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.second {
                    return form
                } else {
                    word.removeLast()
                    word += "īd"
                }
            }
        case .third:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.third {
                    return form
                } else {
                    word.removeLast()
                    word += "ī"
                }
            case .dual:
                return "-"
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.third {
                    return form
                } else {
                    word.removeLast()
                    word += "īn"
                }
            }
        }
        
        return word
    }
    
    func generateConjugationPresentIndicative(person: Person, number: Number) -> String? {
        var word = original
        
        if let verbFirst = verb?.forms.first {
            word = verbFirst
        }
        
        switch person {
        case .first:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.first {
                    return form
                } else {
                    word += "ō"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.first {
                    return form
                } else {
                    word += "ōz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.first {
                    return form
                } else {
                    word += "amaz"
                }
            }
        case .second:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.second {
                    return form
                } else {
                    word += "izi"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.second {
                    return form
                } else {
                    word += "adiz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.second {
                    return form
                } else {
                    word += "id"
                }
            }
        case .third:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.third {
                    return form
                } else {
                    word += "idi"
                }
            case .dual:
                return "-"
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.third {
                    return form
                } else {
                    word += "andi"
                }
            }
        }
        
        return word
    }
    
    func generateConjugationPresentSubjunctive(person: Person, number: Number) -> String? {
        var word = original
        
        if let verbFirst = verb?.forms.first {
            word = verbFirst
        }
        
        switch person {
        case .first:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.first {
                    return form
                } else {
                    word += "aų"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.first {
                    return form
                } else {
                    word += "aiw"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.first {
                    return form
                } else {
                    word += "aim"
                }
            }
        case .second:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.second {
                    return form
                } else {
                    word += "aiz"
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.second {
                    return form
                } else {
                    word += "aidiz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.second {
                    return form
                } else {
                    word += "aid"
                }
            }
        case .third:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.third {
                    return form
                } else {
                    word += "ai"
                }
            case .dual:
                return "-"
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.third {
                    return form
                } else {
                    word += "ain"
                }
            }
        }
        
        return word
    }
    
    func generateConjugationPresentImperative(person: Person, number: Number) -> String? {
        var word = original
        
        if let verbFirst = verb?.forms.first {
            word = verbFirst
        }
        
        switch person {
        case .first:
            return "-"
        case .second:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.second {
                    return form
                }
            case .dual:
                if let form = verb?.special?.subjunctive?.dual?.second {
                    return form
                } else {
                    word += "adiz"
                }
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.second {
                    return form
                } else {
                    word += "id"
                }
            }
        case .third:
            switch number {
            case .singular:
                if let form = verb?.special?.subjunctive?.singular?.third {
                    return form
                } else {
                    word += "adau"
                }
            case .dual:
                return "-"
            case .plural:
                if let form = verb?.special?.subjunctive?.plural?.third {
                    return form
                } else {
                    word += "andau"
                }
            }
        }
        
        return word
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
            switch declension {
            case "ja":
                var vocativeForm = base
                
                vocativeForm?.removeLast()
                
                if vocativeForm?.last != "i" {
                    vocativeForm! += "i"
                }
                
                return vocativeForm
            default:
                return base
            }
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
