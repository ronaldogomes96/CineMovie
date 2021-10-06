//
//  MoviesCoordinator.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

final class MoviesCoordinator: HomeCoordinator {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        let modelManager = ModelParseController()
        
        let controller = MoviesViewController(coordinator: self, modelManager: modelManager)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showMovie(with parse: MovieControllerParse) {
        let coordinator = MovieCoordinator(navigationController: navigationController, controllerResponse: parse)
        coordinator.start()
    }
}
