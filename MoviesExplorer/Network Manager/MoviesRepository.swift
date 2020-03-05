//
//  MoviesRepository.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 05/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct MoviesRepository {
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "eb37167bfd6e6ce5bdd51ff7ad360c75"
    
    private let session = URLSession.shared
    
    func getMoviesList(categoryId: Int? = nil, completion: @escaping ((MovieListResponse?) -> Void)) {
        var params: [URLQueryItem] = []
        if let category = categoryId {
            params.append(URLQueryItem(name: "with_genres", value: "\(category)"))
        }
        
        let moviesUrl = buildUrl(path: ApiEndpoint.list, queryParams: params)
        if let url = moviesUrl?.url {
            session.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                completion(try? JSONDecoder().decode(MovieListResponse.self, from: data))
            }).resume()
        }
    }
    
    func getMovieDetails(id: Int, completion: @escaping ((MovieDetailsResponse?) -> Void)) {
        var detailsUrl = buildUrl(path: ApiEndpoint.details)
        detailsUrl?.path += String(id)
        if let url = detailsUrl?.url {
            print(url)
            session.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                completion(try? JSONDecoder().decode(MovieDetailsResponse.self, from: data))
            }).resume()
        }
    }
    
    private func buildUrl(path: ApiEndpoint, queryParams: [URLQueryItem]? = nil) -> URLComponents? {
        var url = URLComponents(string: "\(self.baseUrl)\(path.rawValue)")
        let apiKeyParam = URLQueryItem(name: "api_key", value: self.apiKey)
        url?.queryItems = [apiKeyParam]
        if let params = queryParams {
            url?.queryItems! += params
        }
        return url
    }
}

enum ApiEndpoint: String {
    case list = "/discover/movie"
    case details = "/movie/"
}
