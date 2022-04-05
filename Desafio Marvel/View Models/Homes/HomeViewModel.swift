//
//  HeroViewModel.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import Foundation

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private var services: HomeListServicesProtocol
    var hero: Hero?
    
    init(services: HomeListServicesProtocol) {
        self .services = services
    }
    
    func fetchHero() {
        services.execute { result in
            switch result {
                case .success(let hero):
                    self.success(hero: hero)
                case .failure(let error):
                    self.error(error: error.localizedDescription)
            }
        }
    }
                      
    private func success(hero: Hero) {
        self.hero = hero
        delegate?.heroFetchWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchHero(error)
    }
}
