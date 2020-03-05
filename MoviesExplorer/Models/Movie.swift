//
//  Movie.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 03/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct Movie {
    var title: String
    var subtitle: String?
    var year: Int
    var duration: Int?
    var categories: [String]?
    var synopsis: String?
    var trailerUrl: String?
    var imageUrl: String?
    var posterUrl: String?
    
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
        guard let imageUrl = self.imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
    
    func getPosterUrl() -> URL? {
        guard let posterUrl = self.posterUrl else {
            return nil
        }
        return URL(string: posterUrl)
    }
    
}
