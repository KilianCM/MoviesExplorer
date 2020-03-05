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

    var movies: [MovieResponse] = [
//        Movie(
//            title: "Rush",
//            subtitle: "Two rivals, one incredible true story.",
//            year: 2013,
//            duration: 123,
//            categories: ["Drame", "Biopic"],
//            synopsis: "RUSH retrace le passionnant et haletant combat entre deux des plus grands rivaux que l’histoire de la Formule 1 ait jamais connus, celui de James Hunt et Niki Lauda concourant pour les illustres écuries McLaren et Ferrari. Issu de la haute bourgeoisie, charismatique et beau garçon, tout oppose le play-boy anglais James Hunt à Niki Lauda, son adversaire autrichien, réservé et méthodique. RUSH suit la vie frénétique de ces deux pilotes, sur les circuits et en dehors, et retrace la rivalité depuis leurs tout débuts.",
//            trailerUrl: "https://www.youtube.com/watch?v=lzNbGH1oZJc",
//            imageUrl: "https://www.europeauto-nissan.com/blog/wp-content/uploads/2013/10/Rush-film-course-automobile-f1-formule1.jpg",
//            posterUrl: "https://fr.web.img3.acsta.net/pictures/210/238/21023887_20130801123843604.jpg"
//        ),
//        Movie(
//            title: "Les Visiteurs",
//            subtitle: "Ils ne sont pas nés d'hier",
//            year: 1993,
//            duration: 105,
//            categories: ["Comédie"],
//            synopsis: "Comment en l'an de grace 1112 le comte de Montmirail et son fidele ecuyer, Jacquouille la Fripouille, vont se retrouver propulses en l'an 1992 apres avoir bu une potion magique fabriquee par l'enchanteur Eusaebius leur permettant de se defaire d'un terrible sort...",
//            trailerUrl: "https://www.youtube.com/watch?v=qN4iuQRLE60",
//            imageUrl: "https://i.ytimg.com/vi/fCqeoTHbWKc/maxresdefault.jpg",
//            posterUrl: "https://fr.web.img6.acsta.net/medias/nmedia/18/36/07/69/18659413.jpg"
//        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 1...100 {
//            movies.append(Movie(
//                title: "Les Visiteurs",
//                subtitle: "Ils ne sont pas nés d'hier",
//                year: 1993,
//                duration: 105,
//                categories: ["Comédie"],
//                synopsis: "Comment en l'an de grace 1112 le comte de Montmirail et son fidele ecuyer, Jacquouille la Fripouille, vont se retrouver propulses en l'an 1992 apres avoir bu une potion magique fabriquee par l'enchanteur Eusaebius leur permettant de se defaire d'un terrible sort...",
//                trailerUrl: "https://www.youtube.com/watch?v=qN4iuQRLE60",
//                imageUrl: "https://i.ytimg.com/vi/fCqeoTHbWKc/maxresdefault.jpg"
//            ))
//        }

        tableView.delegate = self // delegate = ListViewController because he implements the UITableViewDelegate protocol
        tableView.dataSource = self // dataSource = ListViewController because he implements the UITableViewDataSource protocol
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil /*or Bundle.main*/), forCellReuseIdentifier: movieCellIdentifier) // link cells with MovieTableViewCell XIB
        tableView.reloadData()
        
        let networkManager = NetworkManager()
        networkManager.getMovies(with: 28) { response in
            if let movies = response?.results {
                self.movies = movies
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
        let movie = Movie(from: movies[indexPath.item])
        cell.fillDataWith(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: segueIdentifier, sender: Movie(from: movies[indexPath.item]))
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
            if let movie = sender as? Movie {
                movieViewController.movie = movie
            }
        }
    }
}
