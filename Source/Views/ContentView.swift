//
//  ContentView.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 17.12.23..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = MainController()
    @State private var isSidebarActive = false
    
    var settings: some View {
        Group {
            #if os(iOS)
            HStack(spacing: 4) {
                Spacer()
                Button(action: {isSidebarActive.toggle() }, label: {
                    Image(systemName: "xmark.circle")
                })
            }
            
            .padding(.trailing)
            #endif
            
            Form {
                Picker("Word Type", selection: $controller.selectedWordType) {
                    Text("All").tag(Optional<WordType>(nil))
                    ForEach(WordType.allCases, id: \.self) { wordType in
                        Text(wordType.rawValue.capitalized).tag(Optional(wordType))
                    }
                }

                Picker("Search Direction", selection: $controller.searchDirection) {
                    ForEach(SearchDirection.allCases, id: \.self) { direction in
                        Text(direction.description(direction: direction)).tag(direction)
                    }
                }
            }
            .padding()
            
         }
         .padding()
    }
    
    var body: some View {
        #if os(iOS)
        Button(action: {isSidebarActive.toggle() }, label: {
            Spacer()
            Image(systemName: "gear")
                
        })
        .sheet(isPresented: $isSidebarActive) {
            settings
        }
        .padding(.trailing)
        #endif
        
        // Main Content
        VStack {
            TextField(controller.searchDirection == .englishToPraGerm ? "Enter English word" : "Enter Pra Germ word", text: $controller.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            ScrollView {
                LazyVStack(alignment: .leading) { // Use LazyVStack for improved performance
                    ForEach(controller.filteredWords) { word in
                        WordDetailView(word: word, searchDirection: controller.searchDirection)
                    }
                }
            }
        }
        .padding()
        #if os(iOS)
        .onTapGesture {
            self.endTextEditing()
        }
        #endif
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { isSidebarActive.toggle() }, label: {
                    Image(systemName: "gear")
                })
                .sheet(isPresented: $isSidebarActive) {
                    HStack(spacing: 4) {
                        Spacer()
                        Button(action: {isSidebarActive.toggle() }, label: {
                            Image(systemName: "xmark.circle")
                        })
                    }
                    
                    settings
                }
            }
        }
        #endif
    }
}

#Preview {
    ContentView()
}

extension View {
  func endTextEditing() {
    #if os(iOS)
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    #endif
  }
}
