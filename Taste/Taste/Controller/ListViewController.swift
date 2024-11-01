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
    lazy var groupedRecipes : [String:[RecipeModel]] = [:]
    lazy var cuisineTypes: [String] = []
    
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
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.headerReferenceSize = CGSize(width: headerWidth, height: headerHeight)
        layout.minimumLineSpacing = collectionMinLineSpacing
        layout.minimumInteritemSpacing = collectionMinInteritemSpacing
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(CuisineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CuisineHeaderView.reuseIdentifier)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = collectionBackgroundColor
        view.addSubview(collectionView)
        
        // load recipes
//        recipeManager.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        recipeManager.fetchRecipes_local("valid")
    }
    
    @objc func malformedButtonTapped() {
//        recipeManager.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        recipeManager.fetchRecipes_local("malformed")
    }
    @objc func emptyButtonTapped() {
//        recipeManager.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        recipeManager.fetchRecipes_local("empty")
    }
    @objc func sortButtonTapped() {
        
        if recipes.isEmpty {
            let alert = ErrorAlertController(title: "No Recipes", message: "There is no recipe in the list right now. Sort it later!", preferredStyle: .alert)
            self.present(alert, animated: true)
            return
        }
        
        // group by cuisine, and sort sections by A-Z
        groupedRecipes = Dictionary(grouping: recipes, by: { $0.cuisine })
        cuisineTypes = groupedRecipes.keys.sorted()
        
        collectionView.reloadData()
        
        let alert = ErrorAlertController(title: "Sorted", message: "The recipes are now grouped by cuisine. Sections are sorted by name in A-Z order.", preferredStyle: .alert)
        self.present(alert, animated: true)
    }
    @objc func refreshButtonTapped() {
//        recipeManager.fetchRecipes(with: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        recipeManager.fetchRecipes_local("valid")
    }
}

extension ListViewController: RecipeManagerDelegate {
    
    func didUpdateRecipes(_ recipeManager: RecipeManager, recipes: [RecipeModel]) {
        self.recipes = recipes
        groupedRecipes = [:]
        cuisineTypes = []
        
        DispatchQueue.main.async {
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
    
    func didFailWithError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.emptyView.isHidden = false
            
            let alert = ErrorAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated: true)
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cuisineTypes.isEmpty ? 1 : cuisineTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cuisineTypes.isEmpty {
            return recipes.count
        }
        let cuisine = cuisineTypes[section]
        return groupedRecipes[cuisine]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        if cuisineTypes.isEmpty {
            cell.configure(with: recipes[indexPath.item])
        } else {
            let cuisine = cuisineTypes[indexPath.section]
            if let specificCuisineRecipes = groupedRecipes[cuisine] {
                cell.configure(with: specificCuisineRecipes[indexPath.item])
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CuisineHeaderView.reuseIdentifier, for: indexPath) as! CuisineHeaderView
                
                if !cuisineTypes.isEmpty {
                    let cuisine = cuisineTypes[indexPath.section]
                    header.textLabel.text = cuisine
                    header.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1.0)
                } else {
                    header.textLabel.text = ""
                    header.backgroundColor = .clear
                }
                return header
                
            } else if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
                return footer
            }
        return UICollectionReusableView()
        }
}
