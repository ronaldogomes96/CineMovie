//
//  MoviesResponse.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 30/09/21.
//

import Foundation
import CoreData

struct MoviesResponse: Codable {
    var results: [Movie]
    var total_pages: Int?
}

struct Movie: Codable {
    var originalTitle: String
    var overview: String
    var postImageUrl: String
    var releaseDate: String
    var title: String
    var voteAverage: Double
    var id: Double
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case postImageUrl = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        
        case overview
        case title
        case id
    }
}
