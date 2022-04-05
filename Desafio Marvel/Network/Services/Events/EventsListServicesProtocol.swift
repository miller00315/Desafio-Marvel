//
//  EventListServicesProtocol.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import Foundation

enum EventError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessedData
}

protocol EventsListServicesProtocol: AnyObject {
    func execute(id: Int, handler: @escaping(Result<Events, EventError>) -> Void)
}
