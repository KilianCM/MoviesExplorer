//
//  NetworkManager.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 04/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation
import UIKit

struct NetworkManager {
    
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "eb37167bfd6e6ce5bdd51ff7ad360c75"
        
    private let session = URLSession.shared
            
    func downloadImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data))
        })
    }

    func getMovies(with genre: Int, completion: @escaping ((MovieListResponse?) -> Void)) {
        let genreQueryParam = URLQueryItem(name: "with_genres", value: "\(genre)")
        var movieDbUrl = buildMovieDBUrl(route: ApiRoute.movies)
        movieDbUrl?.queryItems?.append(genreQueryParam)
        if let url = movieDbUrl?.url {
            print(url)
            session.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                completion(try? JSONDecoder().decode(MovieListResponse.self, from: data))
            }).resume()
        }
    }
    
    private func buildMovieDBUrl(route: ApiRoute) -> URLComponents? {
        var url = URLComponents(string: "\(self.baseUrl)\(route.rawValue)")
        let apiKeyParam = URLQueryItem(name: "api_key", value: self.apiKey)
        url?.queryItems = [apiKeyParam]
        return url
    }
    
}

enum ApiRoute: String {
    case movies = "/discover/movie"
}
