//
//  ViewController.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())

        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    lazy var homeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Marvel API"
        label.font = UIFont.systemFont(ofSize:  42, weight: .semibold)
        label.textColor = UIColor(named: "AccentColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Controller"
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(collectionView)
        view.addSubview(homeLabel)

        delegates()
        setupConstraints()
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    private func delegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let size = Int(view.frame.size.width / 6)
        
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        
        return layout
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  35),
            homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 85),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
            
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let service = HeroListServices()
        
        service.execute { result in
            switch result {
            case .success(let hero):
                var thumb: String = ""
                if let path = hero.data?.results![indexPath.row].thumbnail?.path {
                    thumb = path
                    thumb.append(".")
                    
                    if let ext = hero.data?.results![indexPath.row].thumbnail?.thumbnailExtension {
                        thumb.append(ext.rawValue.lowercased())
                    } else {
                        thumb.append("jpg")
                    }
                }
                print("\(thumb)")
                cell.heroImage.loadImage(from: thumb)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }

        return cell
    }

}
