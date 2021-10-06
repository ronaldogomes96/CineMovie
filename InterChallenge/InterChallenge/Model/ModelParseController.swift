//
//  ModelParseController.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 01/10/21.
//

import Foundation

class ModelParseController: ModelManager {
    private var moviesServices: MoviesServices
    private var repositoryManager: Repository
    private var coreDataManager: CoreDataManager
    private var apiRoute: ApiRoute
    
    private lazy var isMoviesJSONSaved = false
    private lazy var actualPage = 0
    private lazy var numberOfTotalPages = 0
    
    init(moviesServices: MoviesServices = MoviesServicesUseCase(),
         repositoryManager: Repository = RepositoryManager(),
         coreDataManager: CoreDataManager = MovieCoreDataManager(),
         apiRoute: ApiRoute = ApiRoute()) {
        self.moviesServices = moviesServices
        self.repositoryManager = repositoryManager
        self.coreDataManager = coreDataManager
        self.apiRoute = apiRoute
    }
    
    func getListOfMoviesFor(page: Int, completion: @escaping ([Movie]?) -> Void) {
        if isMoviesJSONSaved && actualPage == page {
            completion(repositoryManager.readAllMovies())
        } else {
            moviesServices.getAllMovies(for: page) { [weak self] in
                switch $0 {
                case .success(let movies):
                    self?.repositoryManager.save(movies: movies)
                    completion(self?.repositoryManager.readAllMovies())
                    self?.isMoviesJSONSaved = true
                    self?.numberOfTotalPages = movies.total_pages ?? 50

                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
        
        actualPage = page
    }
    
    func isFavorite(_ movie: MovieControllerParse) -> Bool {
        return coreDataManager.exists(this: movie.id)
    }
    
    func getAllFavorites() -> [MovieControllerParse] {
        guard let favorites = coreDataManager.readAllMoviesParsed() else {
            return []
        }
        
        return favorites
    }
    
    func delete(favorite: MovieControllerParse) {
        coreDataManager.delete(movie: favorite)
    }
    
    func addNew(favorite: MovieControllerParse) {
        coreDataManager.save(movie: favorite)
    }
    
    func getImageUrl(_ url: String) -> URL {
        return URL(string: apiRoute.imagesURL + url)!
    }
    
    func getTotalNumberOfPages() -> Int {
        return numberOfTotalPages
    }
}
