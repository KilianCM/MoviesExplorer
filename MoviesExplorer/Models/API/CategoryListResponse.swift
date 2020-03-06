//
//  CategoryListResponse.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct CategoryListResponse: Decodable {
    let genres: [Genre]
    
    func transformToCategoryArray() -> [Category] {
        return self.genres.compactMap { genre -> Category in
            Category(from: genre)
        }
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
