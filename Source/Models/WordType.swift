//
//  WordType.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

enum WordType: String, Codable, CaseIterable {
    case noun
    case verb
    case pronoun
    case adverb
    case conjunction
    case interjection
    case adjective
    case participle
    case preposition
    case phrase
    case number
}
