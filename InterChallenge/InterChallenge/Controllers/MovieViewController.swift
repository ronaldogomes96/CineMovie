//
//  MovieViewController.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

class MovieViewController: UITableViewController {
    private var coordinator: Coordinator
    private var modelManager: ModelManager
    private var movie: MovieControllerParse
    
    init(coordinator: Coordinator,
         modelManager: ModelManager,
         movie: MovieControllerParse) {
        self.coordinator = coordinator
        self.modelManager = modelManager
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewCellsAndUI()
        setRightNavigationBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailInformationsCell.identifier) as? MovieDetailInformationsCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: movie)
        
        return cell
    }
            
    @available(iOS 13.0, *)
    @objc func favoriteAction() {
        if modelManager.isFavorite(movie) {
            modelManager.delete(favorite: movie)
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        } else {
            modelManager.addNew(favorite: movie)
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        }
    }
    
    private func setRightNavigationBarButton() {
        if #available(iOS 13.0, *) {
            let buttonImage = modelManager.isFavorite(movie) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            let button = UIBarButtonItem(image: buttonImage, style: .done, target: self, action: #selector(favoriteAction))
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    private func setTableViewCellsAndUI() {
        self.tableView.register(MovieDetailInformationsCell.self, forCellReuseIdentifier: MovieDetailInformationsCell.identifier)
        tableView.tableFooterView = UIView()
    }
}
