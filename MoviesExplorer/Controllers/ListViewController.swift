//
//  ListViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 04/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movieCellIdentifier = "MovieCellId"
    let titleCellIdentifier = "TitleCellId"
    let segueIdentifier = "showDetailsSegue"
    let moviesRepository = MoviesRepository()
    let imageCacheManager = ImageCacheManager()
    
    var movies: [Movie] = []
    var category: Category?
    private var currentPage = 1
    private var shouldLoadMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self // delegate = ListViewController because he implements the UITableViewDelegate protocol
        tableView.dataSource = self // dataSource = ListViewController because he implements the UITableViewDataSource protocol
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil /*or Bundle.main*/), forCellReuseIdentifier: movieCellIdentifier) // link cells with MovieTableViewCell XIB
        tableView.register(UINib(nibName: "CategoryTitleTableViewCell", bundle: nil /*or Bundle.main*/), forCellReuseIdentifier: titleCellIdentifier)
        loadData(page: currentPage)
    }
    
    private func loadData(page: Int) {
        moviesRepository.getMoviesList(page: page, categoryId: category?.id, completion: { response in
            if let movies = response {
                self.shouldLoadMoreData = page < movies.totalPages ?? 0
                let newData = movies.transformToMovieArray()
                var newIndexPaths = [IndexPath]()
                for rowPosition in 0..<newData.count {
                    let newIndexPath = IndexPath(row: self.movies.count + rowPosition, section: 1)
                    newIndexPaths.append(newIndexPath)
                }
                self.movies += newData
                DispatchQueue.main.async() {
                    //self.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: UITableView.RowAnimation.fade)
                    self.tableView.insertRows(at: newIndexPaths, with: .fade)
                }
            }
        })
    }
    
    func createMovieCell(_ tableView: UITableView,_ index: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: index) as! MovieTableViewCell
        cell.prepareForReuse()
        let movie = movies[index.item]
        cell.fillDataWith(movie: movie)
        guard let url = movie.getImageUrl() else {
            return cell
        }

        imageCacheManager.getImage(url: url) { image, imageUrl in
            DispatchQueue.main.async() {
                if imageUrl ==  url.absoluteString {
                    cell.displayImage(image)
                }
            }
        }
        return cell
    }
    
    func createCategoryCell(_ tableView: UITableView,_ index: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: titleCellIdentifier, for: index) as! CategoryTitleTableViewCell
        cell.titleLabel.text = category?.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let movieViewController = segue.destination as! MovieViewController
            if let id = sender as? Int {
                movieViewController.movieId = id
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           return createCategoryCell(tableView, indexPath)
        } else {
            return createMovieCell(tableView, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return movies.count
            default: return 0
        }
    }
    
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: segueIdentifier, sender: movies[indexPath.item].id)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.2,
            delay: 0.1,
            animations: {
                cell.alpha = 1
        })
        
        if indexPath.row == movies.count - 1 && shouldLoadMoreData {
            currentPage += 1
            loadData(page: currentPage)
        }
    }
}
