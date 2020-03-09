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
    
    var movieId: Int = 0
    var movie: Movie?
    let moviesRepository = MoviesRepository()
    let imageCacheManager = ImageCacheManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesRepository.getMovieDetails(id: movieId) { response in
            if let movieResponse = response {
                guard let movie = Movie(from: movieResponse) else {
                    return
                }
                self.movie = movie
                self.loadTrailerUrl(from: movieResponse.videos)
                DispatchQueue.main.async() {
                    self.displayMovieInformation(movie: movie)
                    self.displayMovieImages(movie: movie)
                }
            }
        }
    }
    
    /**
        Request to API to get a Youtube trailer URL
     */
    private func loadTrailerUrl(from movieVideos: MovieVideosResponse?) {
        guard let results = movieVideos?.results else {
            return
        }
        let urlList = results.toUrlList()
        if !urlList.isEmpty {
            self.movie?.trailerUrl = urlList[0]
            self.displayPlayButton()
        }
    }
    
    /**
        Remove the hidden property for the Play button
     */
    private func displayPlayButton() {
        DispatchQueue.main.async() {
            self.playButton.isHidden = false
        }
    }
 
    /**
        Request to API to download movie image and movie poster and display these images in ImageView
     */
    private func displayMovieImages(movie: Movie) {
        if let url = movie.getImageUrl() {
            imageCacheManager.getImage(url: url) { image, imageUrl in
                DispatchQueue.main.async() {
                    if imageUrl ==  url.absoluteString {
                        self.movieImageView.image = image
                    }
                }
            }
        }
        if let url = movie.getPosterUrl() {
            imageCacheManager.getImage(url: url) { image, imageUrl in
                DispatchQueue.main.async() {
                    if imageUrl ==  url.absoluteString {
                        self.posterImageView.image = image
                    }
                }
            }
        }
    }

    /**
        Populate UILabels with movie information
     */
    private func displayMovieInformation(movie: Movie) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.subtitle
        if let year = movie.year {
            yearLabel.text = String(year)
        }
        durationLabel.text = movie.getDurationAsString()
        categoriesLabel.text = movie.getCategoriesAsString()
        synopsisLabel.text = movie.synopsis
    }
    
    /**
        Open the trailer URL on click on Play button
     */
    @IBAction func playTrailerVideo(_ sender: Any) {
        if let url = movie?.getTrailerUrl() {
            UIApplication.shared.open(url)
        }
    }
}

