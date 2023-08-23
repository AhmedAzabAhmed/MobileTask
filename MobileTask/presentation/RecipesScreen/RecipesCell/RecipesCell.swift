//
//  RecipesCell.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import UIKit
import Kingfisher

class RecipesCell: UICollectionViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(with model: RecipesModel) {
        recipeName.text = model.name
        recipeImage.kf.indicatorType = .activity
        if let url = URL(string: model.image) {
            recipeImage.kf.setImage(with: url)
        }
    }
    
}
