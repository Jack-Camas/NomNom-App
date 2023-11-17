//
//  EventCell.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    static let id = "ResultEventCell"
    weak var delegate: SearchResultCellDelegate?
    
    // MARK: - Properties
    
    var isHeartButtonSelected: Bool = false {
        didSet {
            let image = isHeartButtonSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            heartButton.setImage(image, for: .normal)
            heartButton.tintColor = isHeartButtonSelected ? .red : .gray
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadConstraints()
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadConstraints() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            rateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            rateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            heartButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func heartButtonTapped() {
        
        delegate?.togglHeartBtn(for: self)
    }
}

protocol SearchResultCellDelegate: AnyObject {
    func togglHeartBtn(for cell: SearchResultCell)
}
