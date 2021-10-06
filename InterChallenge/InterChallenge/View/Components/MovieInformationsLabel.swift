//
//  MovieInformationsLabel.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

class MovieInformationsLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.numberOfLines = 0
        self.backgroundColor = .clear
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
