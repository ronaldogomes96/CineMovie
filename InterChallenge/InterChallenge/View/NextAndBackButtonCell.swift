//
//  NextAndBackButtonCell.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 03/10/21.
//

import UIKit

class NextAndBackButtonCell: UITableViewCell, ViewCodable {
    private lazy var backPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("< Página Anterior", for: .normal)
        button.addTarget(self, action: #selector(backPageAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 0
        return button
    }()
    
    private lazy var nextPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Proxima Página >", for: .normal)
        button.addTarget(self, action: #selector(nextPageAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 1
        return button
    }()
    
    static let identifier = "NextAndBackButtonCell"
    
    var page: Int? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.backPageButton.isHidden = (self?.page == 1)
                self?.nextPageButton.isHidden = (self?.page == self?.lastPageNumber)
            }
        }
    }
    
    var lastPageNumber: Int?
    
    weak var delegate: UpdateTableViewData?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        setupView()
    }
    
    func buildViewHierarchy() {
        addSubviews(backPageButton, nextPageButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backPageButton.topAnchor.constraint(equalTo: topAnchor, constant: 30 * Multipliers.height),
            backPageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 30 * Multipliers.widht),
            backPageButton.rightAnchor.constraint(equalTo: centerXAnchor),
            
            nextPageButton.topAnchor.constraint(equalTo: topAnchor, constant: 30 * Multipliers.height),
            nextPageButton.leftAnchor.constraint(equalTo: centerXAnchor),
            nextPageButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30 * Multipliers.widht)
        ])
    }
    
    @objc private func backPageAction() {
        delegate?.updateDataForPreviousPage()
    }
    
    @objc private func nextPageAction() {
        delegate?.updateDataForNextPage()
    }
}
