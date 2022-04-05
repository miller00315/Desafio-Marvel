//
//  EventsViewController.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import UIKit

class EventsViewController: UIViewController {
    var heroEvents: Comics?
    var viewModel: EventsViewModel?
    
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
                self.tableView.reloadData()
            }
        case .error:
            return
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hero Events"
        
        view.backgroundColor = UIColor(named: "Background")
        view.addSubview(tableView)
        
        delegates()
        fetchEvent()
        state = .loading
        setupConstraints()
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.identifier)
    }
    
    private func fetchEvent() {
        guard let viewModel = viewModel else {
            return state = .error
        }
        
        viewModel.fetchEvent()
    }
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.event?.data?.results!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier, for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = viewModel?.event?.data?.results![indexPath.row].title
        
        var thumb: String = ""
        if let path = viewModel?.event?.data?.results![indexPath.row].thumbnail?.path {
            thumb = path
            thumb.append(".")
            if let ext = viewModel?.event?.data?.results![indexPath.row].thumbnail?.thumbnailExtension?.rawValue.lowercased() {
                thumb.append(ext)
            } else {
                thumb.append("jpg")
                }
            }
        
        let kfLoader = KFImageLoader()
        let placeholder = UIImage(named: "placeholderImage")
        
        kfLoader.load(imageURL: thumb, placeholder: placeholder!, imageView: cell.eventHeroImage)
        cell.descriptionLabel.text = viewModel?.event?.data?.results![indexPath.row].resultDescription
        
        return cell
    }    
}

extension EventsViewController: EventsViewModelDelegate {
    func eventFetchWithSuccess() {
        state = .normal
    }
    
    func errorToFetchEvent(_ error: String) {
        state = .error
    }
}
