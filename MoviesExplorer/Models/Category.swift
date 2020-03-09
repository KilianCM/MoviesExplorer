//
//  Category.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct Category {
    let id: Int
    let name: String
    
    init?(from genre: Genre) {
        guard let id = genre.id, let name = genre.name else {
            return nil
        }
        self.id = id
        self.name = name
    }
}
