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
    
    static var shared = NetworkManager()
    let session = URLSession.shared
    
    func fetchData(_ url: URL, completion: @escaping (Data) -> Void) -> Void {
        self.session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                return
            }
            
            if let data = data {
                completion(data)
            }
        }).resume()
    }
}
