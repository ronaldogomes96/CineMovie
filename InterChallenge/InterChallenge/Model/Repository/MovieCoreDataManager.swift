//
//  MovieCoreDataManager.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 01/10/21.
//

import CoreData

public class MovieCoreDataManager: NSManagedObject, CoreDataManager {
    
    func save(movie: MovieControllerParse) {
        if exists(this: movie.id) {
            return
        }
        
        let movieData = MovieCoreDataManager(context: CoreDataStack.viewContext)
        
        parse(movieControllerData: movie, for: movieData)
        
        CoreDataStack.saveContext()
    }
    
    func readAllMoviesParsed() -> [MovieControllerParse]? {
        return parse(movieData: readAllMovies())
    }
    
    private func readAllMovies() -> [MovieCoreDataManager]? {
        let request: NSFetchRequest<MovieCoreDataManager> = MovieCoreDataManager.fetchRequest()
        guard let movies = try? CoreDataStack.viewContext.fetch(request) else {
            return nil
        }
        
        return movies
    }
    
    func delete(movie: MovieControllerParse) {
        readAllMovies()?.forEach {
            if $0.id == movie.id {
                CoreDataStack.viewContext.delete($0)
                
                CoreDataStack.saveContext()
            }
        }
    }
    
    func exists(this id: Double) -> Bool {
        var exists = false
        
        readAllMoviesParsed()?.forEach {
            if $0.id == id {
                exists = true
            }
        }
        
        return exists
    }
    
    // Testar
    private func parse(movieData: [MovieCoreDataManager]?) -> [MovieControllerParse]? {
        return movieData?.compactMap {
            MovieControllerParse(originalTitle: $0.originalTitle ?? "",
                                 overview: $0.overview ?? "",
                                 postImageData: $0.postImage ?? Data(),
                                 releaseDate: $0.releaseDate ?? Date(),
                                 title: $0.title ?? "",
                                 voteAverage: $0.voteAverage,
                                 id: $0.id)
        }
    }
    
    // Testar
    @discardableResult
    private func parse(movieControllerData: MovieControllerParse, for movieData: MovieCoreDataManager = MovieCoreDataManager()) -> MovieCoreDataManager {
        let movieData = movieData
        
        movieData.title = movieControllerData.title
        movieData.id = movieControllerData.id
        movieData.originalTitle = movieControllerData.originalTitle
        movieData.overview = movieControllerData.overview
        movieData.postImage = movieControllerData.postImageData
        movieData.releaseDate = movieControllerData.releaseDate
        movieData.voteAverage = movieControllerData.voteAverage
        
        return movieData
    }
}
