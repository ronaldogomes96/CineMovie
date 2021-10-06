//
//  RepositoryManagerTests.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 30/09/21.
//

import XCTest
@testable import InterChallenge

class RepositoryManagerTests: XCTestCase {
    private let pathName = "MoviesTest"
    
    override func tearDown() {
        let repository = RepositoryManager(pathName: pathName)
        try? FileManager.default.removeItem(at: repository.urlPath!)
    }
    
    func test_initAndCreatePath_shouldNotBeNil() {
        // Given
        let sut = RepositoryManager(pathName: pathName)
        
        // Then
        XCTAssertNotNil(sut.urlPath)
    }
    
    func test_save_validMovies_returnsTrue() {
        // Given
        let sut = RepositoryManager(pathName: pathName)
        
        // When
        let isSaved = sut.save(movies: getValidMoviesResponses())
        
        // Then
        XCTAssertTrue(isSaved)
    }
    
    func test_save_invalidUrl_returnsFalse() {
        // Given
        let sut = RepositoryManager(pathName: pathName)
        
        // When
        sut.urlPath = nil
        let isSaved = sut.save(movies: getValidMoviesResponses())
        
        // Then
        XCTAssertFalse(isSaved)
    }
    
    func test_readAllMovies_returnsTwoValidMovies() {
        // Given
        let sut = RepositoryManager(pathName: pathName)
        _ = sut.save(movies: getValidMoviesResponses())
        
        // When
        let movies = sut.readAllMovies()
        
        // Then
        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 2)
    }
    
    func test_readAllMovies_loadWrongData_returnsNil() {
        // Given
        let sut = RepositoryManager(pathName: pathName)
        
        // When
        mockWrongDataSaved(sut)
        let movies = sut.readAllMovies()
        
        // Then
        XCTAssertNil(movies)
    }
    
    // MARK: - Help functions
    func getValidMoviesResponses() -> MoviesResponse {
        let movie = Movie(originalTitle: "Movie One", overview: "", postImageUrl: "", releaseDate: "", title: "", voteAverage: 0.0, id: 0.0)
        
        return MoviesResponse(results: [movie, movie])
    }
    
    func mockWrongDataSaved(_ sut: RepositoryManager) {
        let jsonData = try? JSONEncoder().encode([0, 1, 2])
        try? jsonData!.write(to: sut.urlPath!)
    }
}
