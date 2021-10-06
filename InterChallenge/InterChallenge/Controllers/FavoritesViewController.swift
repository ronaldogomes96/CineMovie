//
//  FavoritesViewController.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

class FavoritesViewController: UITableViewController {
    private var coordinator: HomeCoordinator
    private var modelManager: ModelManager
    private var movies: [MovieControllerParse]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    init(coordinator: HomeCoordinator,
         modelManager: ModelManager)  {
        self.coordinator = coordinator
        self.modelManager = modelManager
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Favoritos"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        movies = modelManager.getAllFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else {
            return 0
        }

        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 * Multipliers.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = movies,
              let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
            fatalError("Cannot load cell or movies")
        }
        
        cell.movieTitle = movies[indexPath.row].title
        cell.movieImageView.image = UIImage(data: movies[indexPath.row].postImageData)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.row] else {
            return
        }
        
        coordinator.showMovie(with: movie)
    }
}
