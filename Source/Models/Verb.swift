//
//  Verb.swift
//  PraGermDictionary
//
//  Created by Andrey Skurlatov on 21.1.24..
//

import Foundation

struct Verb: Codable {
    var type: VerbType
    var vclass: VerbClass
    var forms: VerbForms
    var special: VerbSpecial?

}

struct VerbSpecial: Codable {
    var indicative: VerbSpecialNumber?
    var subjunctive: VerbSpecialNumber?
    var imperative: VerbSpecialNumber?
}

struct VerbSpecialNumber: Codable {
    var singular: VerbSpecialPerson?
    var dual: VerbSpecialPerson?
    var plural: VerbSpecialPerson?
}

struct VerbSpecialPerson: Codable {
    var first: String?
    var second: String?
    var third: String?
}

struct VerbForms: Codable {
    var first: String
    var second: String
    var third: String
}

enum VerbClass: String, CaseIterable, Codable {
    case first
    case second
    case third
}

enum VerbType: String, CaseIterable, Codable {
    case strong
    case weak
}

enum Mood: String, CaseIterable, Codable {
    case indicative
    case subjunctive
    case imperative
}

enum Tense: String, CaseIterable, Codable {
    case present
    case past
}
