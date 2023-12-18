//
//  MainController.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

// Enum to represent the different search directions
enum SearchDirection: String, CaseIterable {
    case englishToPraGerm
    case praGermToEnglish
    
    func description(direction: SearchDirection) -> String {
        switch direction {
        case .englishToPraGerm:
            return "English to Pra Germ"
        case .praGermToEnglish:
            return "Pra Germ to English"
        }
    }
}

// Class to control the word search functionality
class MainController: ObservableObject {
    // Published properties that will trigger UI updates when they change
    @Published var searchQuery: String = ""
    @Published var searchDirection: SearchDirection = .praGermToEnglish
    @Published var selectedWordType: WordType?
    // Instance of WordService to handle word data operations
    var wordService: MainService

    
    // Computed property to return the filtered words based on the search query and selected word type
    var filteredWords: [Word] {
        if !searchQuery.isEmpty || selectedWordType != nil {
            return wordService.searchWords(for: searchQuery, searchDirection: searchDirection, wordType: selectedWordType)
        } else {
            // Show all loaded words when the search query is empty
            return wordService.words.sorted(by: {
                if $1.original > $0.original {
                    return true
                }
                return false
            })
        }
    }

    // Initializer
    init() {
        // Initialize MainService
        wordService = MainService()
    }
    
}
