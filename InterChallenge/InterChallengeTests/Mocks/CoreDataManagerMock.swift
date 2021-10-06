//
//  CoreDataManagerMock.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation
@testable import InterChallenge

class CoreDataManagerMock: CoreDataManager {
    var isForReadAllMovies = false
    var isCallDelete = false
    var isCallSave = false
    
    func save(movie: MovieControllerParse) {
        isCallSave = true
    }
    
    func readAllMoviesParsed() -> [MovieControllerParse]? {
        if isForReadAllMovies {
            return [MovieControllerParse(originalTitle: "",
                                        overview: "",
                                        postImageData: Data(),
                                        releaseDate: Date(),
                                        title: "",
                                        voteAverage: 0.0,
                                        id: 0.0)]
        } else {
            return nil
        }
    }
    
    func delete(movie: MovieControllerParse) {
        isCallDelete = true
    }
    
    func exists(this id: Double) -> Bool {
        return true
    }
    
    
}
