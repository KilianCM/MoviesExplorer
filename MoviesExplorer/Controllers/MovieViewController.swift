//
//  ViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 03/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //var movie = Movie(title: "Rush", subtitle: "Two rivals, one incredible true story.", year: 2013, duration: 123, categories: ["Drame", "Biopic"], synopsis: "RUSH retrace le passionnant et haletant combat entre deux des plus grands rivaux que l’histoire de la Formule 1 ait jamais connus, celui de James Hunt et Niki Lauda concourant pour les illustres écuries McLaren et Ferrari. Issu de la haute bourgeoisie, charismatique et beau garçon, tout oppose le play-boy anglais James Hunt à Niki Lauda, son adversaire autrichien, réservé et méthodique. RUSH suit la vie frénétique de ces deux pilotes, sur les circuits et en dehors, et retrace la rivalité depuis leurs tout débuts.", trailerUrl: "https://www.youtube.com/watch?v=lzNbGH1oZJc")
    
    var movie: Movie?
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if movie?.getTrailerUrl() != nil {
            playButton.isHidden = false
        }
        
        titleLabel.text = movie?.title
        subtitleLabel.text = movie?.subtitle
        if let year = movie?.year {
            yearLabel.text = String(year)
        }
        durationLabel.text = movie?.getDurationAsString()
        categoriesLabel.text = movie?.getCategoriesAsString()
        synopsisLabel.text = movie?.synopsis
        if let url = movie?.getImageUrl() {
            networkManager.downloadImage(from: url) { image in
                DispatchQueue.main.async() {
                    self.movieImageView.image = image
                }
            }
        }
        if let url = movie?.getPosterUrl() {
            networkManager.downloadImage(from: url) { image in
                DispatchQueue.main.async() {
                    self.posterImageView.image = image
                }
            }
        }
    }

    @IBAction func playTrailerVideo(_ sender: Any) {
        if let url = movie?.getTrailerUrl() {
            UIApplication.shared.open(url)
        }
    }
}

