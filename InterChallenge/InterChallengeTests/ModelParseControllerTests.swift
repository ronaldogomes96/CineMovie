//
//  ModelParseControllerTests.swift
//  InterChallengeTests
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import XCTest
@testable import InterChallenge

class ModelParseControllerTests: XCTestCase {
    private var moviesServices: MoviesServices?
    private var repositoryManager: Repository?
    private var coreDataManager: CoreDataManager?
    
    override func setUp() {
        self.moviesServices = MoviesServicesMock()
        self.repositoryManager = RepositoryManagerMock()
        self.coreDataManager = CoreDataManagerMock()
    }
    
    func test_getListOfMoviesFor_succesCase_shouldBeNotNil() {
        // Given
        let moviesServicesMock = MoviesServicesMock()
        let sut = ModelParseController(moviesServices: moviesServicesMock,
                                       repositoryManager: repositoryManager!,
                                       coreDataManager: coreDataManager!)
        
        // When
        moviesServicesMock.isSuccess = true
        
        sut.getListOfMoviesFor(page: 1) { result in
            // Then
            XCTAssertNotNil(result)
        }
    }
    
    func test_getListOfMoviesFor_failureCase_shouldBeNil() {
        // Given
        let moviesServicesMock = MoviesServicesMock()
        let sut = ModelParseController(moviesServices: moviesServicesMock,
                                       repositoryManager: repositoryManager!,
                                       coreDataManager: coreDataManager!)
        
        // When
        moviesServicesMock.isSuccess = false
        
        sut.getListOfMoviesFor(page: 1) { result in
            // Then
            XCTAssertNil(result)
        }
    }
    
    func test_getListOfMoviesFor_jsonSavedAndActualPage_shouldCallreadAllMovies() {
        // Given
        let moviesServicesMock = MoviesServicesMock()
        let repositoryManagerMock = RepositoryManagerMock()
        let sut = ModelParseController(moviesServices: moviesServicesMock,
                                       repositoryManager: repositoryManagerMock,
                                       coreDataManager: coreDataManager!)
        
        // When
        moviesServicesMock.isSuccess = true
        
        sut.getListOfMoviesFor(page: 1) { _ in }
        sut.getListOfMoviesFor(page: 1) { result in
            // Then
            XCTAssertNotNil(result)
        }
    }
    
    func test_isFavorite_shouldReturnTrue() {
        // Given
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataManager!)
        
        // When
        let isFavorite = sut.isFavorite(getMovieControllerParse())
        
        // Then
        XCTAssertTrue(isFavorite)
    }
    
    func test_getAllFavorites_coreDataReturnNil_shouldReturnEmpty() {
        // Given
        let coreDataMock = CoreDataManagerMock()
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataMock)
        
        // When
        coreDataMock.isForReadAllMovies = false
        let allFavorites = sut.getAllFavorites()
        
        // Then
        XCTAssertTrue(allFavorites.isEmpty)
    }
    
    func test_getAllFavorites_coreDataReturnValue_shouldReturnNotEmpty() {
        // Given
        let coreDataMock = CoreDataManagerMock()
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataMock)
        
        // When
        coreDataMock.isForReadAllMovies = true
        let allFavorites = sut.getAllFavorites()
        
        // Then
        XCTAssertFalse(allFavorites.isEmpty)
    }
    
    func test_delete_shouldCallCoreDataDelete() {
        // Given
        let coreDataMock = CoreDataManagerMock()
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataMock)
        
        // When
        sut.delete(favorite: getMovieControllerParse())
        
        // Then
        XCTAssertTrue(coreDataMock.isCallDelete)
    }
    
    func test_addNew_shouldCallCoreDataSave() {
        // Given
        let coreDataMock = CoreDataManagerMock()
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataMock)
        
        // When
        sut.addNew(favorite: getMovieControllerParse())
        
        // Then
        XCTAssertTrue(coreDataMock.isCallSave)
    }
    
    func test_getImageUrl_testString_shouldReturnUrl() {
        // Given
        let sut = ModelParseController(moviesServices: moviesServices!,
                                                 repositoryManager: repositoryManager!,
                                                 coreDataManager: coreDataManager!)
        
        // When
        let imageUrl = sut.getImageUrl("/testUrl")
        
        // Then
        XCTAssertEqual(imageUrl, URL(string: "https://image.tmdb.org/t/p/w500//testUrl"))
    }
    
    func test_getTotalNumberOfPages_shouldReturnTen() {
        // Given
        let moviesServicesMock = MoviesServicesMock()
        let sut = ModelParseController(moviesServices: moviesServicesMock,
                                       repositoryManager: repositoryManager!,
                                       coreDataManager: coreDataManager!)
        
        // When
        moviesServicesMock.isSuccess = true
        sut.getListOfMoviesFor(page: 10) { _ in }
        
        // Then
        XCTAssertEqual(10, sut.getTotalNumberOfPages())
    }
    
    // MARK: - Helper functions
    private func getMovieControllerParse() -> MovieControllerParse {
        return MovieControllerParse(originalTitle: "",
                                    overview: "",
                                    postImageData: Data(),
                                    releaseDate: Date(),
                                    title: "",
                                    voteAverage: 0.0,
                                    id: 0.0)
    }
}
