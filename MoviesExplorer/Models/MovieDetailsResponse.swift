//
//  MovieResponse.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 05/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let id: Int
    let backdropPath: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
    }
}
