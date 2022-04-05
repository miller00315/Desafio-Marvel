//
//  DetailsViewController.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import UIKit

class DetailsViewController: UIViewController {
    var heroDetails: ResultHero?
    
    lazy var heroCard: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "CardBackground")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = heroDetails?.name
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var showEventsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Show Events", for: .normal)
        let underlineAttriString = NSAttributedString(string: (button.titleLabel?.text!)!, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.titleLabel?.attributedText = underlineAttriString
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(callEventsView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        
        var path = heroDetails?.thumbnail?.path!
        path!.append(".jpg")
        image.loadImage(from: path!)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hero Details"
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(heroCard)
        heroCard.addSubview(horizontalStack)
        heroCard.addSubview(heroImage)
        
        horizontalStack.addArrangedSubview(heroNameLabel)
        horizontalStack.addArrangedSubview(showEventsButton)
        setupConstraints()
    }
    
    @objc func callEventsView() {
        let services = EventListServices()
        let viewModel = EventsViewModel(services: services)
        let vc = EventsViewController()
        
        vc.viewModel = viewModel
        vc.viewModel?.idEvent = heroDetails?.id
        vc.heroEvents = heroDetails?.events
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heroCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            heroCard.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heroCard.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            heroCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42),
            
            horizontalStack.topAnchor.constraint(equalTo: heroCard.topAnchor, constant: 25),
            horizontalStack.leadingAnchor.constraint(equalTo: heroCard.leadingAnchor, constant: 22),
            horizontalStack.trailingAnchor.constraint(equalTo: heroCard.trailingAnchor, constant: -22),
            
            heroImage.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 85),
            heroImage.centerXAnchor.constraint(equalTo: heroCard.centerXAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 332),
            heroImage.heightAnchor.constraint(equalToConstant: 420),
        ])
    }
}
