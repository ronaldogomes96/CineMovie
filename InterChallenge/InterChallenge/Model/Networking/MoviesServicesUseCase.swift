//
//  MoviesServicesUseCase.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 30/09/21.
//

import Foundation
import Alamofire

class MoviesServicesUseCase: MoviesServices {
    private var route: ApiRoute
    
    init(route: ApiRoute = ApiRoute()) {
        self.route = route
    }

    func getAllMovies(for page: Int = 1, with completion: @escaping  (Result<MoviesResponse, NetworkErrors>) -> Void) {        
        AF.request(route.moviesURL, parameters: getRouteParameters(with: page)).responseDecodable(of: MoviesResponse.self) {
            
            guard let data = $0.data,
                  let response = try? JSONDecoder().decode(MoviesResponse.self, from: data) else {
                      completion(.failure(.badData))
                      return
            }
            
            completion(.success(response))
        }
    }
    
    private func getRouteParameters(with page: Int) -> [String: Any] {
        return ["api_key" : "c2e78b4a8c14e65dd6e27504e6df95ad",
                "language" : "pt-BR",
                "page" : page]
    }
}
