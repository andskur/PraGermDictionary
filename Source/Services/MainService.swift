//
//  MainService.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import Foundation

class MainService {
    // The array of Word objects loaded from the WordsData.json file
    var words: [Word] = []

    init() {
        loadWords()
    }

    // This function loads the word data from the WordsData.json file
    func loadWords() {
        guard let fileURL = Bundle.main.url(forResource: "WordsData", withExtension: "json") else {
            fatalError("Failed to locate WordsData.json file.")
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let words = try decoder.decode([Word].self, from: data)
            
            var newWords = [Word]()
            
            for word in words {
                newWords.append(word)
            }
            
            self.words = newWords // Update the words property
        } catch {
            fatalError("Failed to load WordsData.json: \(error)")
        }
    }
    
    // This function searches for words based on a search query, a search direction, and a word type
    func searchWords(for searchQuery: String, searchDirection: SearchDirection, wordType: WordType?) -> [Word] {
        let lowercaseQuery = searchQuery.lowercased()
        var filteredWords: [Word] = words

        if wordType != nil {
            filteredWords = filteredWords
                .filter { $0.type == wordType }
                .sorted(by: {
                    if $1.original > $0.original {
                        return true
                    }
                    
                    return false
                })
        }

        if !searchQuery.isEmpty {
            filteredWords = filterWords(filteredWords, with: lowercaseQuery, searchDirection: searchDirection)
        }
        
        return filteredWords
    }

    // This function filters the words based on a query and a search direction
    func filterWords(_ words: [Word], with query: String, searchDirection: SearchDirection) -> [Word] {
        let lowercaseQuery = query.lowercased()

        return words.filter { word in
            return wordMatchesQuery(word, query: lowercaseQuery)
        }
        .sorted(by: {
            if $1.original.count > $0.original.count {
                return true
            }
            return false
        })
    }
    
    // This function checks if a word matches a query
    func wordMatchesQuery(_ word: Word, query: String) -> Bool {
        let wordMatchesQuery = word.original.lowercased().contains(query)
        
        
        return wordMatchesQuery
    }
}
