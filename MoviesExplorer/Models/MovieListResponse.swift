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
}
