//
//  CategoriesRepository.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation


struct CategoriesRepository {
    /**
        Make request to MovieDB API to get categories list
     */
    func getCategoriesList(completion: @escaping ((CategoryListResponse?) -> Void)) {
        let categoriesUrl = APIManager.shared.buildUrl(path: ApiEndpoint.categories, queryParams: nil)
        if let url = categoriesUrl?.url {
            NetworkManager.shared.fetchData(url) { data in
                completion(try? JSONDecoder().decode(CategoryListResponse.self, from: data))
            }
        }
    }
}
