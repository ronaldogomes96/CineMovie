//
//  MovieView.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 02/10/21.
//

import UIKit

class MovieDetailInformationsCell: UITableViewCell, ViewCodable {
    private lazy var movietitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieOriginalTitleLabel = MovieInformationsLabel()
    private lazy var movieDescriptionLabel = MovieInformationsLabel()
    private lazy var movieReleaseDateLabel = MovieInformationsLabel()
    private lazy var movieVoteAverageLabel = MovieInformationsLabel()
    
    static let identifier = "MovieDetailInformationsCell"
    
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
        addSubviews(movietitleLabel, movieImageView, movieOriginalTitleLabel, movieDescriptionLabel, movieReleaseDateLabel, movieVoteAverageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movietitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20 * Multipliers.height),
            movietitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movietitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.widht),
            
            movieImageView.topAnchor.constraint(equalTo: movietitleLabel.bottomAnchor, constant: 20 * Multipliers.height),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 300 * Multipliers.height),
            
            movieOriginalTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20 * Multipliers.height),
            movieOriginalTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movieOriginalTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.height),
            
            movieDescriptionLabel.topAnchor.constraint(equalTo: movieOriginalTitleLabel.bottomAnchor, constant: 20 * Multipliers.height),
            movieDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movieDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.height),
            
            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 20 * Multipliers.height),
            movieReleaseDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movieReleaseDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.height),
            
            movieVoteAverageLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: 20 * Multipliers.height),
            movieVoteAverageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20 * Multipliers.widht),
            movieVoteAverageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20 * Multipliers.height),
            movieVoteAverageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100 * Multipliers.height)
        ])
    }
    
    func setupCell(with movie: MovieControllerParse) {
        movieImageView.image = UIImage(data: movie.postImageData)
        movietitleLabel.text = movie.title
        movieOriginalTitleLabel.text =  "Título Original: " + movie.originalTitle
        movieDescriptionLabel.text = "Descrição: " + movie.overview
        movieReleaseDateLabel.text = "Data de lançamento: " + (movie.releaseDate.convertToString() ?? "")
        movieVoteAverageLabel.text = "Nota: " + String(movie.voteAverage)
    }
}
