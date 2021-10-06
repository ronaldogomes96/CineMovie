//
//  MoviesServices.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation

protocol MoviesServices {
    func getAllMovies(for page: Int, with completion: @escaping  (Result<MoviesResponse, NetworkErrors>) -> Void) 
}
