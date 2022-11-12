//
//  WordService.swift
//  WordGame
//
//  Created by Reza Bina on 11/12/22.
//

import Foundation

protocol WordService {
    func load() throws -> [WordModel]
}
