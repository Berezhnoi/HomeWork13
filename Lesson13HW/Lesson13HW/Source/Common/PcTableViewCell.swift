//
//  PcTableViewCell.swift
//  Lesson13HW
//
//  Created by rendi on 07.04.2024.
//

import UIKit

class PcTableViewCell: UITableViewCell {
    static let identifier = "PcTableViewCell";
    
    // Define a closure property to handle favorite button tap
    var favoriteButtonTapped: ((Bool) -> Void)?
    
    let pcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "pcPlaceholder")
        imageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        return imageView
    }()
    
    let productCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let manufacturerModelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let ratingView: RatingView = RatingView(maxRating: 5)
    
    let priceCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart_empty"), for: .normal)
        button.setImage(UIImage(named: "heart_filled"), for: .selected)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
        ])
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set the action for the favorite button
        favoriteButton.addTarget(self, action: #selector(handleFavoriteButtonTap(_:)), for: .touchUpInside)
        
        let detailsStackView = UIStackView(arrangedSubviews: [productCodeLabel, nameLabel, manufacturerModelLabel])
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 8
        
        let imageAndDetailsStackView = UIStackView(arrangedSubviews: [pcImageView, detailsStackView])
        imageAndDetailsStackView.axis = .horizontal
        imageAndDetailsStackView.spacing = 18
        
        let ratingAndPriceStackView = UIStackView(arrangedSubviews: [ratingView, priceCurrencyLabel])
        ratingAndPriceStackView.axis = .vertical
        ratingAndPriceStackView.spacing = 8
        
        // Create an empty placeholder view to occupy available space
        let placeholderView = UIView()
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        let actionStackView = UIStackView(arrangedSubviews: [ratingAndPriceStackView, placeholderView, favoriteButton])
        actionStackView.axis = .horizontal
        
        // Add stack views to the cell's content view
        contentView.addSubview(imageAndDetailsStackView)
        contentView.addSubview(actionStackView)
        
        // Define constraints for imageAndDetailsStackView
        imageAndDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageAndDetailsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageAndDetailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageAndDetailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        // Define constraints for actionStackView
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStackView.topAnchor.constraint(equalTo: imageAndDetailsStackView.bottomAnchor, constant: 12),
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleFavoriteButtonTap(_ sender: UIButton) {
        // Toggle the selected state of the favoriteButton
        sender.isSelected = !sender.isSelected
        
        // Call the closure to notify the view controller about the favorite button tap
        favoriteButtonTapped?(sender.isSelected)
     }
}

