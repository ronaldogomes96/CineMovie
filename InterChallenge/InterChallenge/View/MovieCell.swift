//
//  MovieCell.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell, ViewCodable {
    lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        if #available(iOS 13.0, *) {
            image.backgroundColor = .systemGray2
        }
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieTitle: String? {
        didSet {
            movieTitleLabel.text = movieTitle
        }
    }
    
    static let identifier = "MovieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        setupView()
    }
    
    func buildViewHierarchy() {
        addSubviews(movieImageView, movieTitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20 * Multipliers.height),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20 * Multipliers.height),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movieImageView.widthAnchor.constraint(equalToConstant: 80 * Multipliers.widht),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieTitleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 20 * Multipliers.widht),
            movieTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.widht)
        ])
    }
    
    func getMovieImageData() -> Data? {
        return movieImageView.image?.pngData()
    }
}
