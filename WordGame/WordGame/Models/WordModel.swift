//
//  WordModel.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

struct WordModel : Codable {
    var english: String
    var spanish: String
    
    enum CodingKeys : String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
}

extension WordModel: Equatable {
    static func == (lhs: WordModel, rhs: WordModel) -> Bool {
        return (lhs.english.lowercased() == rhs.english.lowercased()) && (lhs.spanish.lowercased() == rhs.spanish.lowercased())
    }
}
