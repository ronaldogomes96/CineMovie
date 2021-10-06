//
//  ViewCodable.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import Foundation

public protocol ViewCodable {
    func buildViewHierarchy()
    func setupConstraints()
}

public extension ViewCodable {
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
    }
}
