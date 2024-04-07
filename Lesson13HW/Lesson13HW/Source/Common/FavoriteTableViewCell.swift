//
//  FavoriteTableViewCell.swift
//  Lesson13HW
//
//  Created by rendi on 06.04.2024.
//


import UIKit

class FavoriteTableViewCell: UITableViewCell {
    static let identifier = "FavoriteTableViewCell";
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let manufacturerModelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add labels to the cell's content view
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(manufacturerModelLabel)
        
        // Define constraints for labels
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            manufacturerModelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            manufacturerModelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            manufacturerModelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
