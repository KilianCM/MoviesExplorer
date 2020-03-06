//
//  APIManager.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation

struct APIManager {
    static var shared = APIManager()
    
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "eb37167bfd6e6ce5bdd51ff7ad360c75"
    let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    /**
        Create an URLComponent object with an API endpoint and query params
     */
    func buildUrl(path: ApiEndpoint, queryParams: [URLQueryItem]? = nil) -> URLComponents? {
        var url = URLComponents(string: "\(self.baseUrl)\(path.rawValue)")
        url?.queryItems = [
            URLQueryItem(name: "api_key", value: self.apiKey),
            URLQueryItem(name: "language", value: "fr-FR")
        ]
        if let params = queryParams {
            url?.queryItems! += params
        }
        return url
    }
}

/**
 List of used endpoints of the MovieDB API
 */
enum ApiEndpoint: String {
    case list = "/discover/movie"
    case details = "/movie/"
    case categories = "/genre/movie/list"
}
