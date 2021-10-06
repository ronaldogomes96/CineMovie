//
//  MoviesServicesMock.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation
@testable import InterChallenge

class MoviesServicesMock: MoviesServices {
    var isSuccess = false
    
    func getAllMovies(for page: Int, with completion: @escaping (Result<MoviesResponse, NetworkErrors>) -> Void) {
        if isSuccess {
            completion(.success(getMovieResponseMock()))
        } else {
            completion(.failure(NetworkErrors.badData))
        }
    }
    
    private func getMovieResponseMock() -> MoviesResponse {
        return MoviesResponse(results: [], total_pages: 10)
    }
}
