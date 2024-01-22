//
//  DynamicTableVerb.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 21.1.24..
//

import SwiftUI

struct DynamicTableVerb: View {
    let word: Word
    
    func Headers(tense: Tense) -> some View {
        Group {
//            HStack(spacing: 0) {
//                Text("")
//                    .frame(minWidth: 87, minHeight: 0, maxHeight: .infinity, alignment: .center)
//                    .padding(.vertical, 10)
//                    .background(Color.gray.opacity(0.2))
//                    .border(Color.black, width: 1)
//                
//                Text(tense.rawValue.capitalized)
//                    .frame(minWidth: 1174.5, minHeight: 0, maxHeight: .infinity, alignment: .center)
//                    .padding(.vertical, 10)
//                    .background(Color.gray.opacity(0.2))
//                    .border(Color.black, width: 1)
//            }
            
            HStack(spacing: 0) {
                Text(tense.rawValue.capitalized)
                    .frame(minWidth: 87, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.2))
                    .border(Color.black, width: 1)
                
                ForEach(Mood.allCases, id: \.rawValue) { mood in
                    if word.shouldShowMood(tense: tense, mood: mood) {
                        Text(mood.rawValue.capitalized)
                            .frame(minWidth: 391.5, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                            .background(Color.gray.opacity(0.2))
                            .border(Color.black, width: 1)
                    }
                }
            }
            
            HStack(spacing: 0) {
                Text("")
                    .frame(minWidth: 87, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.2))
                    .border(Color.black, width: 1)
                
                ForEach(Mood.allCases, id: \.rawValue) { mood in
                    if word.shouldShowMood(tense: tense, mood: mood) {
                        ForEach(Number.allCases, id: \.rawValue) { num in
                            Text(num.rawValue.capitalized)
                                .frame(minWidth: 130.5, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                .padding(.vertical, 10)
                                .background(Color.gray.opacity(0.2))
                                .border(Color.black, width: 1)
                            
                        }
                    }
                }
            }
        }
    }
    
    func Rows(tense: Tense, reflexive: Bool) -> some View {
        ForEach(Person.allCases, id: \.rawValue) { p in
            HStack(spacing: 0) {
                Text(p.rawValue.capitalized)
                    .frame(minWidth: 87, maxWidth: 87)
                    .padding(.vertical, 10)
                    .border(Color.black, width: 1)
                    .background(Color.gray.opacity(0.2))
                
                ForEach(Mood.allCases, id: \.rawValue) { m in
                    if word.shouldShowMood(tense: tense, mood: m) {
                        ForEach(Number.allCases, id: \.rawValue) { num in
                            if let wordWithConjunction = word.generateConjugation(person: p, number: num, tense: tense, mood: m) {
                                Text(wordWithConjunction)
                                    .frame(minWidth: 130.5)
                                    .padding(.vertical, 10)
                                    .border(Color.black, width: 1)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack(alignment: .leading) {
                // Non Reflexive
                ForEach(Tense.allCases, id: \.rawValue) { tense in
                    Headers(tense: tense)
                    
                    Rows(tense: tense, reflexive: false)
                }
            }
        }
    }
    
    private func headerWidth(for mood: Mood) -> CGFloat {
        if mood == .imperative {
            return CGFloat(261)
        } else {
            return CGFloat(391)
        }
    }
    
    private func headerWidth(for number: Number) -> CGFloat {
        let subheaderCount = word.countGenders(for: number)
        
        if word.type == .noun {
            return CGFloat(subheaderCount) * 87.0 * 2
        } else {
           return CGFloat(subheaderCount) * 87.0
        }
    }
    
    func calcWidth() -> CGFloat {
        if word.type == .noun {
            return CGFloat(174.0)
        }
        
        return CGFloat(87.0)
    }
}

#Preview {
    DynamicTableVerb(word: Word(original: "String", declension: "a", type: .adjective, gender: .masculine, translations: [], verb: nil))
}
