//
//  HeroListServicesProtocol.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import Foundation

enum HeroError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessedData
}

protocol HomeListServicesProtocol: AnyObject {
    func execute(handler: @escaping(Result<Hero, HeroError>) -> Void)
    
}
