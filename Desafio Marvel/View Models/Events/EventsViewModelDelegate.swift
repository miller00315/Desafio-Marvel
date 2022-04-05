//
//  EventsViewModelDelegate.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 04/04/22.
//

import UIKit

protocol EventsViewModelDelegate: AnyObject {
    func eventFetchWithSuccess()
    func errorToFetchEvent(_ error: String)
}
