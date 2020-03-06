//
//  Movie.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 03/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int
    var title: String
    var subtitle: String?
    var year: Int?
    var duration: Int?
    var categories: [String]?
    var synopsis: String?
    var trailerUrl: String?
    var imageUrl: String
    var posterUrl: String?
    
    init(from movieResponse: MovieResponse) {
        self.id = movieResponse.id
        self.title = movieResponse.title
        self.year = Int(String(movieResponse.releaseDate.prefix(4)))
        self.synopsis = movieResponse.overview
        self.imageUrl = APIManager.shared.imageBaseUrl + "w300" + movieResponse.backdropPath
    }
    
    init(from movieDetailsResponse: MovieDetailsResponse) {
        self.id = movieDetailsResponse.id
        self.title = movieDetailsResponse.title
        self.year = Int(String(movieDetailsResponse.releaseDate.prefix(4)))
        self.synopsis = movieDetailsResponse.overview
        self.imageUrl = APIManager.shared.imageBaseUrl + "w500" + movieDetailsResponse.backdropPath
        self.posterUrl = APIManager.shared.imageBaseUrl + "w200" + movieDetailsResponse.posterPath
        self.duration = movieDetailsResponse.runtime
        self.categories = movieDetailsResponse.genres.map({ genre -> String in
            genre.name
        })
    }
    
    func getCategoriesAsString() -> String {
        guard let categories = self.categories else {
            return "-"
        }
        return categories.joined(separator: ", ")
     }
    
    func getDurationAsString() -> String {
        guard let duration = self.duration else {
            return "-"
        }
        return "\(duration) min"
    }
    
    func getTrailerUrl() -> URL? {
        guard let trailerUrl = self.trailerUrl else {
            return nil
        }
        return URL(string: trailerUrl)
    }
    
    func getImageUrl() -> URL? {
        return URL(string: imageUrl)
    }
    
    func getPosterUrl() -> URL? {
        guard let posterUrl = self.posterUrl else {
            return nil
        }
        return URL(string: posterUrl)
    }
    
}
