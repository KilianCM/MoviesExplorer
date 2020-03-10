//
//  TitleCollectionViewCell.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 10/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "MoviesExplorer"
    }
    
    static var nib: UINib {
        return UINib(nibName: "TitleCollectionViewCell", bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return "TitleCollectionViewCell"
    }

}
