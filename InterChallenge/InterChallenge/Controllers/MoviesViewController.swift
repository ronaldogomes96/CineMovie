//
//  MoviesViewController.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit
import Kingfisher

class MoviesViewController: UITableViewController, UpdateTableViewData {
    private var coordinator: HomeCoordinator
    private var modelManager: ModelManager
    private var movies: [Movie]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var page = 1
    
    init(coordinator: HomeCoordinator,
         modelManager: ModelManager) {
        self.coordinator = coordinator
        self.modelManager = modelManager

        super.init(nibName: nil, bundle: nil)

        title = "Filmes"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewCells()
        updateListOfMoviesAndUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else {
            return 0
        }

        return movies.count + 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 * Multipliers.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = movies else {
            return UITableViewCell()
        }
        
        if movies.count == indexPath.row {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextAndBackButtonCell.identifier) as? NextAndBackButtonCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            cell.lastPageNumber = modelManager.getTotalNumberOfPages()
            cell.page = page
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
                return UITableViewCell()
            }
            
            cell.movieTitle = movies[indexPath.row].title
            cell.movieImageView.kf.setImage(with: modelManager.getImageUrl(movies[indexPath.row].postImageUrl))
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row],
           let cell = tableView.cellForRow(at: indexPath) as? MovieCell {
            
            let parseController = MovieControllerParse(originalTitle: movie.originalTitle,
                                                       overview: movie.overview,
                                                       postImageData: cell.getMovieImageData() ?? Data(),
                                                       releaseDate: movie.releaseDate.convertToDate() ?? Date(),
                                                       title: movie.title,
                                                       voteAverage: Double(movie.voteAverage),
                                                       id: Double(movie.id))
            
            coordinator.showMovie(with: parseController)
        }
    }
    
    func updateDataForNextPage() {
        page += 1
        updateListOfMoviesAndUI()
    }
    
    func updateDataForPreviousPage() {
        page -= 1
        updateListOfMoviesAndUI()
    }
    
    private func updateListOfMoviesAndUI() {
        modelManager.getListOfMoviesFor(page: page) { [weak self] in
            self?.movies = $0
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    private func setTableViewCells() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(NextAndBackButtonCell.self, forCellReuseIdentifier: NextAndBackButtonCell.identifier)
    }
}
