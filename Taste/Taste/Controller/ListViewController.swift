//
//  ViewController.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import UIKit

class ListViewController: UIViewController {
    
    var recipeManager = RecipeManager()
    
    var recipes: [RecipeModel] = []
    var collectionView: UICollectionView!
    var emptyView: EmptyListView!
    
    var isFirstLoaded = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeManager.delegate = self
        
        // navigation bar
        self.title = "Taste"
        view.backgroundColor = backgroundColor
        navigationController?.navigationBar.backgroundColor = navigationBarColor
        navigationController?.navigationBar.tintColor = navigationBarButtonColor
        
        let malformedButton = UIBarButtonItem(image: UIImage(systemName: "exclamationmark.circle"), style: .plain, target: self, action: #selector(malformedButtonTapped))
        let emptyButton = UIBarButtonItem(image: UIImage(systemName: "circle.dashed"), style: .plain, target: self, action: #selector(emptyButtonTapped))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonTapped))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        
        
        navigationItem.leftBarButtonItems = [malformedButton, emptyButton]
        navigationItem.rightBarButtonItems = [refreshButton, sortButton]
        
        // empty view
        emptyView = EmptyListView(frame: self.view.bounds)
        view.addSubview(emptyView)
        
        // collection view
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: collectionCellHeight)
        layout.minimumLineSpacing = collectionMinLineSpacing
        layout.minimumInteritemSpacing = collectionMinInteritemSpacing
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = collectionBackgroundColor
        view.addSubview(collectionView)
        
        // load recipes
//        recipeManager.fetchEmployees(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        recipeManager.fetchEmployees_local("valid")
    }
    
    @objc func malformedButtonTapped() {
//        recipeManager.fetchEmployees(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        recipeManager.fetchEmployees_local("malformed")
    }
    @objc func emptyButtonTapped() {
//        recipeManager.fetchEmployees(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        recipeManager.fetchEmployees_local("empty")
    }
    @objc func sortButtonTapped() {
        recipes.sort { $0.name < $1.name }
        collectionView.reloadData()
        let alert = ErrorAlertController(title: "Sorted", message: "The recipes are sorted by name in A-Z order now.", preferredStyle: .alert)
        self.present(alert, animated: true)
    }
    @objc func refreshButtonTapped() {
//        recipeManager.fetchEmployees(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        recipeManager.fetchEmployees_local("valid")
    }
}

extension ListViewController: RecipeManagerDelegate {
    
    func didUpdateRecipes(_ recipeManager: RecipeManager, recipes: [RecipeModel]) {
        self.recipes = recipes
        
        Dispatch.main.async {
            self.collectionView.reloadData()
            
            if recipes.count == 0 {
                self.emptyView.isHidden = false
            } else {
                self.emptyView.isHidden = true
                
                if !self.isFirstLoaded {
                    let alert = ErrorAlertController(title: "Refreshed", message: "The updated list of recipes is loaded now.", preferredStyle: .alert)
                    self.present(alert, animated: true)
                }
                self.isFirstLoaded = false
            }
        }
    }
    
    func didFailWithError(error: error) {
        print(error)
        DispatchQueue.main.async {
            self.emptyView.isHidden = false
            
            let alert = ErrorAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated: true)
        }
    }
}
