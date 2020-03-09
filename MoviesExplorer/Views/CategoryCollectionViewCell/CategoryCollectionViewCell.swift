//
//  CategoryCollectionViewCell.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 09/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstLetterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        //setShadow()
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = 10
    }
    
    func configureWithName(name: String) {
        nameLabel.text = name
        if let firstLetter = name.first {
            firstLetterLabel.text = String(firstLetter)
        } else {
            firstLetterLabel.isHidden = true
        }
    }
    

}
