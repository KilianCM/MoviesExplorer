//
//  CategoriesViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 06/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Category] = []
    
    let categoriesRepository = CategoriesRepository()
    let cellIdentifier = "CategoryCollectionViewCell"
    let segueIdentifier = "showMoviesSegue"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil ), forCellWithReuseIdentifier: cellIdentifier)

        categoriesRepository.getCategoriesList { response in
            if let genres = response {
                self.categories = genres.transformToCategoryArray()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let listViewController = segue.destination as! ListViewController
            if let category = sender as? Category {
                listViewController.category = category
            }
        }
    }

}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifier, sender: categories[indexPath.item])
    }
}

extension CategoriesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        cell.configureWithName(name: categories[indexPath.item].name)
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

