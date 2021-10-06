//
//  FileManagerManager.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 30/09/21.
//

import Foundation

class RepositoryManager: Repository {
    var urlPath: URL?
    private var manager = FileManager.default
    
    init(pathName: String = "Movies") {
        createPath(with: pathName)
    }
    
    private func createPath(with pathName: String) {
        let pathUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileUrl = pathUrl.appendingPathComponent(pathName)
        fileUrl = fileUrl.appendingPathExtension("json")
        self.urlPath = fileUrl
    }
    
    @discardableResult
    func save(movies: MoviesResponse) -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(movies)
            try jsonData.write(to: urlPath ?? URL(fileURLWithPath: ""))
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func readAllMovies() -> [Movie]? {
        do {
            let jsonData = try Data(contentsOf: urlPath ?? URL(fileURLWithPath: ""))
            let moviesResult = try JSONDecoder().decode(MoviesResponse.self, from: jsonData)
            return moviesResult.results
        } catch {
            print(error)
            return nil
        }
    }
}
