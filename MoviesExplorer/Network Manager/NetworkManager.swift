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
    
    private let session = URLSession.shared
            
    func downloadImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data))
        }).resume()
    }
}
