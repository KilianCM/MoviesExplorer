//
//  MovieListResponse.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 05/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation



import Foundation

struct MovieListResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieResponse]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    func transformToMovieArray() -> [Movie] {
        return self.results.map { movieReponse -> Movie in
            Movie(from: movieReponse)
        }
    }
}

struct MovieResponse: Codable {
    let id: Int
    let backdropPath: String
    let genres: [Int]
    let title: String
    let overview: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
    }
}
