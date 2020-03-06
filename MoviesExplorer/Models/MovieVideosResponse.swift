//
//  MovieVideosResponse.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 05/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct MovieVideosResponse: Decodable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Decodable {
    let key: String
    let site: String
    
    func transformToStringUrl() -> String? {
        if self.site == "YouTube" {
            return "https://www.youtube.com/watch?v=\(self.key)"
        }
        return nil
    }
}

extension Array where Element == MovieVideo {
    func toUrlList() -> [String] {
        return self.compactMap { (movieVideo: MovieVideo) -> String? in
            movieVideo.transformToStringUrl()
        }
    }
}
