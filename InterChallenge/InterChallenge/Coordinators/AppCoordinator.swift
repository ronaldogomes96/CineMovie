//
//  AppCoordinator.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        cordinateToTabBar()
    }
    
    private func cordinateToTabBar() {
        let tabBarCordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCordinator)
    }
}
