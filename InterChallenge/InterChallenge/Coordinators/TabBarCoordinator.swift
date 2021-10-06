//
//  TabBarCoordinator.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBar = TabBarController(coordinator: self)
        
        let moviesNavigation = getMoviesNavigation()
        let moviesCoordinator = MoviesCoordinator(navigationController: moviesNavigation)
        
        let favoritesNavigation = getFavoritesNavigation()
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigation)
        
        tabBar.viewControllers = [moviesNavigation, favoritesNavigation]
        tabBar.modalPresentationStyle = .fullScreen
        
        navigationController.present(tabBar, animated: false, completion: nil)
        
        coordinate(to: moviesCoordinator)
        coordinate(to: favoritesCoordinator)
    }
    
    private func getMoviesNavigation() -> UINavigationController {
        let navigationController = UINavigationController()
        if #available(iOS 13.0, *) {
            navigationController.tabBarItem = UITabBarItem(title: "Filmes", image: UIImage(systemName: "film"), tag: 0)
        }
        return navigationController
    }
    
    private func getFavoritesNavigation() -> UINavigationController {
        let navigationController = UINavigationController()
        if #available(iOS 13.0, *) {
            navigationController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star.fill"), tag: 0)
        }
        return navigationController
    }
}
