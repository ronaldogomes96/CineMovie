//
//  Repository.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 30/09/21.
//

import Foundation

protocol Repository {    
    @discardableResult
    func save(movies: MoviesResponse) -> Bool
    func readAllMovies() -> [Movie]?
}
