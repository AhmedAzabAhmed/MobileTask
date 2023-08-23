//
//  RecipesDetailsViewController.swift
//  MobileTask
//
//  Created by Ahmed Azab on 23/08/2023.
//

import UIKit
import Kingfisher

class RecipesDetailsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    private var recipesModel: RecipesModel?
    
    required init(model: RecipesModel) {
        super.init(nibName: nil, bundle: nil)
        self.recipesModel = model
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        guard let model  = recipesModel else { return }
        nameLabel.text = model.name
        descriptionLabel.text = model.name
        ingredientsLabel.text = model.ingredients
        recipeImage.kf.indicatorType = .activity
        if let url = URL(string: model.image) {
            recipeImage.kf.setImage(with: url)
        }
    }
    
}
