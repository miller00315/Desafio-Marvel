//
//  HomeCollectionViewCell.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeCollectionViewCell"
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 10
        image.layer.accessibilityPath?.stroke()
        image.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        image.layer.borderWidth = 0.8
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImage)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImage.topAnchor.constraint(equalTo: topAnchor),
            heroImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
