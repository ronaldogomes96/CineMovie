//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
