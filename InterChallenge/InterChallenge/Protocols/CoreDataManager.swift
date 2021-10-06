//
//  CoreDataManager.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation

protocol CoreDataManager {
    func save(movie: MovieControllerParse)
    func readAllMoviesParsed() -> [MovieControllerParse]?
    func delete(movie: MovieControllerParse)
    func exists(this id: Double) -> Bool
}
