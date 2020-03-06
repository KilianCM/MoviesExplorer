//
//  ImageCache.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheManager {
    var cache: [String: UIImage] = [:]
    
    func getImage(url: URL, completion: @escaping ((UIImage, String) -> Void)) {
        if let image = cache[url.absoluteString] {
            completion(image, url.absoluteString)
        } else {
            NetworkManager.shared.fetchData(url) { data in
                if let image = UIImage(data: data) {
                    self.cache[url.absoluteString] = image
                    completion(image, url.absoluteString)
                }
            }
        }
    }
}
