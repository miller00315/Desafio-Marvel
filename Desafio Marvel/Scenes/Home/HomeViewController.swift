//
//  ViewController.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    
    private enum ViewState {
        case loading
        case normal
        case error
    }
    
    private var state: ViewState = .normal {
        didSet {
            self.setupView()
        }
    }
    
    private func setupView() {
        switch state {
        case .loading:
            return
        case .normal:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .error:
            return
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())

        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var homeImage: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "homeLogo")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var heroesTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Heroes"
        label.font = UIFont.systemFont(ofSize: 42, weight: .regular)
        label.textColor = UIColor(named: "AccentColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let appereance = UINavigationBarAppearance()
        
        appereance.backgroundColor = .secondarySystemGroupedBackground
        appereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.compactAppearance = appereance
        navigationController?.navigationBar.scrollEdgeAppearance = appereance
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(homeImage)
        view.addSubview(heroesTitleLabel)
        view.addSubview(collectionView)

        delegates()
        fetchHero()
        state = .loading
        setupConstraints()
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    private func fetchHero() {
        guard let viewModel = viewModel else {
            return state = .error
        }

        viewModel.fetchHero()
    }
    
    private func delegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.delegate = self
    }
    
    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let size = Int(view.frame.size.width / 4)
        
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        return layout
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            homeImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            homeImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            homeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heroesTitleLabel.topAnchor.constraint(equalTo: homeImage.bottomAnchor, constant:  15),
            heroesTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: heroesTitleLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
            
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.hero?.data?.results?.count ?? 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        var thumb: String = ""
        if let path = viewModel?.hero?.data?.results![indexPath.row].thumbnail?.path {
            thumb = path
            thumb.append(".")
            if let ext = viewModel?.hero?.data?.results![indexPath.row].thumbnail?.thumbnailExtension?.rawValue.lowercased() {
                thumb.append(ext)
            } else {
                thumb.append("jpg")
                }
            }
        
        let kfLoader = KFImageLoader()
        let placeholder = UIImage(named: "placeholderImage")
        
        kfLoader.load(imageURL: thumb, placeholder: placeholder!, imageView: cell.heroImage)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        
        vc.heroDetails = viewModel?.hero?.data?.results![indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func heroFetchWithSuccess() {
        state = .normal
    }
    
    func errorToFetchHero(_ error: String) {
        state = .error
    }
}
