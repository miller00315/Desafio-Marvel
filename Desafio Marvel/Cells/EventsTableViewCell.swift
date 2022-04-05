//
//  EventsTableViewCell.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    static let identifier: String = "EventsTableViewCell"
    
    lazy var eventHeroImage: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(systemName: "square.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title Event"
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = false
        label.highlightedTextColor = .darkGray
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 6
        stack.contentMode = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(eventHeroImage)
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventHeroImage.widthAnchor.constraint(equalToConstant: 120),
            eventHeroImage.heightAnchor.constraint(equalToConstant: 120),
            eventHeroImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            eventHeroImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: eventHeroImage.trailingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
