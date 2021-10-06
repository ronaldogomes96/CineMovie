//
//  ModelManager.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import Foundation

protocol ModelManager {
    func getListOfMoviesFor(page: Int, completion: @escaping ([Movie]?) -> Void)
    func isFavorite(_ movie: MovieControllerParse) -> Bool
    func getAllFavorites() -> [MovieControllerParse]
    func delete(favorite: MovieControllerParse)
    func addNew(favorite: MovieControllerParse)
    func getImageUrl(_ url: String) -> URL
    func getTotalNumberOfPages() -> Int
}
