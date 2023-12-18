//
//  WordDetailView.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 18.12.23..
//

import SwiftUI

struct WordDetailView: View {
    let word: Word
    let searchDirection: SearchDirection
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if searchDirection == .englishToPraGerm || searchDirection == .praGermToEnglish {
                    Text("\(word.original) (\(word.translations[0].text))")
                }
                
                Text(word.type.rawValue.capitalized).italic()
                
                if word.type == .noun || word.type == .pronoun || word.type == .adjective || word.type == .participle {
                    DynamicTable(word: word)
                }

            }
            .padding()
        }
        .navigationTitle(word.original)
    }
}

#Preview {
    WordDetailView(word: Word(original: "texst", base: "base", declension: nil, type: .noun, gender: nil, translations: []), searchDirection: .praGermToEnglish)
}
