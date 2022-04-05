//
//  EventsViewModel.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 04/04/22.
//

import Foundation

class EventsViewModel {
    weak var delegate: EventsViewModelDelegate?
    private var services: EventsListServicesProtocol
    var idEvent: Int?
    var event: Events?
    
    init(services: EventsListServicesProtocol) {
        self .services = services
    }
    
    func fetchEvent() {
        services.execute(id: idEvent!) { result in
            switch result {
                case .success(let event):
                self.success(event: event)
                case .failure(let error):
                    self.error(error: error.localizedDescription)
            }
        }
    }
    
    
    
    private func success(event: Events) {
        self.event = event
        delegate?.eventFetchWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchEvent(error)
    }
}
