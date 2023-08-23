//
//  RecipesViewController.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import UIKit
import Combine
import SkeletonView

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    private let cellIdentifier = "RecipesCell"
    private var recipesViewModel = RecipesViewModel()
    private var cancellable: Set<AnyCancellable> = []
    private var recipesList: [RecipesModel] = []
    private let emptyView = RecipesEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getRecipesCompositionalLayout()
        bind()
        recipesViewModel.getRecipesList()
    }
}

//MARK: - Bind with ViewModel
extension RecipesViewController {
    func bind() {
        recipesViewModel
            .recipesList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.showLoading()
                    
                case .success(let list):
                    self.hideLoading()
                    self.updateUI(list: list)
                    
                case .failure(_):
                    self.hideLoading()
                    self.updateUI(list: [])
                }
            }.store(in: &cancellable)
    }
}

//MARK: - Prepare UI
extension RecipesViewController {
    func setupCollectionView() {
        recipesCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil),
                                       forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func updateUI(list: [RecipesModel]) {
        recipesList.removeAll()
        recipesList.append(contentsOf: list)
        if recipesList.count > 0 {
            hideEmptyView()
        } else {
            showEmptyView()
        }
        recipesCollectionView.reloadData()
    }
    
    private func showEmptyView() {
        recipesCollectionView.backgroundView = emptyView
    }
    
    private func hideEmptyView() {
        recipesCollectionView.backgroundView = nil
    }
    
    private func showLoading() {
        recipesCollectionView.showAnimatedGradientSkeleton()
    }
    
    private func hideLoading() {
        recipesCollectionView.hideSkeleton()
    }
    
    private func getRecipesCompositionalLayout() {
        
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width / 2) - 5), heightDimension: .absolute(164))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: NSCollectionLayoutSpacing.fixed(5), top: NSCollectionLayoutSpacing.fixed(0), trailing: NSCollectionLayoutSpacing.fixed(0), bottom: NSCollectionLayoutSpacing.fixed(0))
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width), heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            return UICollectionViewCompositionalLayout(section: section)
        }()
        recipesCollectionView.setCollectionViewLayout(compositionalLayout, animated: true)
    }
}


//MARK: - collection view delegat, DataSource
extension RecipesViewController: UICollectionViewDelegate, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? RecipesCell else { return UICollectionViewCell() }
        cell.setupCell(with: recipesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipesDetailsViewController = RecipesDetailsViewController(model: recipesList[indexPath.row])
        navigationController?.pushViewController(recipesDetailsViewController, animated: true)
    }
}
