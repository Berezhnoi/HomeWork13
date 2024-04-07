//
//  RatingView.swift
//  Lesson13HW
//
//  Created by rendi on 07.04.2024.
//

import UIKit

class RatingView: UIStackView {
    private var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }
    
    init(maxRating: Int) {
        super.init(frame: .zero)
        self.axis = .horizontal
        self.spacing = 4
        self.distribution = .fillEqually // Make stars fill the available width equally
        setupStars(maxRating: maxRating)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStars(maxRating: Int) {
        for _ in 0..<maxRating {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            addArrangedSubview(starImageView)
        }
        updateRating() // Update rating immediately after setting up stars
    }
    
    func setRating(_ rating: Int) {
        self.rating = rating
    }
    
    private func updateRating() {
        for (index, arrangedSubview) in arrangedSubviews.enumerated() {
            guard let starImageView = arrangedSubview as? UIImageView else { continue }
            if index < rating {
                starImageView.image = UIImage(named: "star_filled") // Use yellow star for filled stars
            } else {
                starImageView.image = UIImage(named: "star") // Use gray star for empty stars
            }
        }
    }
}
