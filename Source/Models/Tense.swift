//
//  Tense.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 21.1.24..
//

import Foundation

enum Tense: String, CaseIterable, Codable {
    case present
    case past
    
    func Title() -> String {
        let title = self.rawValue.capitalized
        
        return title
    }
}
