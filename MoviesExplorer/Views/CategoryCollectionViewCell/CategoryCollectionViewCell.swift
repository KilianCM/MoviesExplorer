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
    
    func setCornerRadius() {
        self.layer.cornerRadius = 10
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }

}
