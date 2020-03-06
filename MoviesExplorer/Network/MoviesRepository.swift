//
//  MoviesRepository.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 05/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct MoviesRepository {
    /**
        Make request to MovieDB API to get movies list
     */
    func getMoviesList(categoryId: Int? = nil, completion: @escaping ((MovieListResponse?) -> Void)) {
        var params: [URLQueryItem] = []
        if let category = categoryId {
            params.append(URLQueryItem(name: "with_genres", value: "\(category)"))
        }
        
        let moviesUrl = APIManager.shared.buildUrl(path: ApiEndpoint.list, queryParams: params)
        if let url = moviesUrl?.url {
            NetworkManager.shared.fetchData(url) { data in
                completion(try? JSONDecoder().decode(MovieListResponse.self, from: data))
            }
        }
    }
    
    /**
        Make request to MovieDB API to get details for a specific movie
     */
    func getMovieDetails(id: Int, completion: @escaping ((MovieDetailsResponse?) -> Void)) {
        var detailsUrl = APIManager.shared.buildUrl(path: ApiEndpoint.details, queryParams: [URLQueryItem(name: "append_to_response", value: "videos")])
        detailsUrl?.path += String(id)
        if let url = detailsUrl?.url {
            NetworkManager.shared.fetchData(url) { data in
                completion(try? JSONDecoder().decode(MovieDetailsResponse.self, from: data))
            }
        }
    }
}


