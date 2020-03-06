//
//  CategoriesViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    let categoriesRepository = CategoriesRepository()
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesRepository.getCategoriesList { response in
            if let genres = response {
                self.categories = genres.transformToCategoryArray()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
