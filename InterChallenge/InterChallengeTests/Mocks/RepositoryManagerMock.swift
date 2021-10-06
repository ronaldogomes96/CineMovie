//
//  RepositoryManagerMock.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation
@testable import InterChallenge

class RepositoryManagerMock: Repository {
    func save(movies: MoviesResponse) -> Bool {
        return true
    }
    
    func readAllMovies() -> [Movie]? {
        return []
    }
}
