//
//  MovieTableViewCell.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 04/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillDataWith(movie: Movie) {
        self.titleLabel.text = movie.title
        self.dateLabel.text = String(movie.year)
        self.synopsisLabel.text = movie.synopsis
        
        if let url = movie.getImageUrl() {
            NetworkManager.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.movieImageView.image = UIImage(data: data)
                }
            }
        }
    }
    

    /**
        Clear data to avoid cached data reused when an item has no data
     */
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.movieImageView.image = nil
        self.dateLabel.text = nil
        self.synopsisLabel.text = nil
    }
    
}
