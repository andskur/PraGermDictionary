//
//  Translation.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

struct Translation: Codable {
    var language: Language
    var text: String
}

enum Language: String, CaseIterable, Codable {
    case English
}
