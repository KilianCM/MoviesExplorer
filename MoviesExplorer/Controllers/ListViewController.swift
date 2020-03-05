//
//  ListViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 04/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movieCellIdentifier = "MovieCellId"
    let segueIdentifier = "showDetailsSegue"

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self // delegate = ListViewController because he implements the UITableViewDelegate protocol
        tableView.dataSource = self // dataSource = ListViewController because he implements the UITableViewDataSource protocol
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil /*or Bundle.main*/), forCellReuseIdentifier: movieCellIdentifier) // link cells with MovieTableViewCell XIB
        tableView.reloadData()
        
        let moviesRepository = MoviesRepository()
        moviesRepository.getMoviesList() { response in
            if let movies = response {
                self.movies = movies.transformToMovieArray()
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        cell.prepareForReuse()
        let movie = movies[indexPath.item]
        cell.fillDataWith(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: segueIdentifier, sender: movies[indexPath.item].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.02 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
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
