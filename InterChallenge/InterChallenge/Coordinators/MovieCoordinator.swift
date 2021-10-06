//
//  MovieCoordinator.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

final class MovieCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let controllerResponse: MovieControllerParse

    init(navigationController: UINavigationController,
         controllerResponse: MovieControllerParse) {
        self.navigationController = navigationController
        self.controllerResponse = controllerResponse
    }
    
    func start() {
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = false
        }
        
        let modelManager = ModelParseController()
        let controller = MovieViewController(coordinator: self,
                                             modelManager: modelManager,
                                             movie: controllerResponse)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
