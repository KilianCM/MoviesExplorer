//
//  ImageCache.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {

    static var shared = ImageCache()
    
    var cache: [String: UIImage] = [:]
    
    func getImage(url: URL, completion: @escaping ((UIImage) -> Void)) {
        if let image = cache[url.absoluteString] {
            completion(image)
        } else {
            NetworkManager.shared.downloadImage(from: url) { image in
                if let image = image {
                    self.cache[url.absoluteString] = image
                    completion(image)
                }
            }
        }
    }
    
}
