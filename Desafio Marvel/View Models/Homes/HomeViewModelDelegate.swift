//
//  HeroViewModelDelegate.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func heroFetchWithSuccess()
    func errorToFetchHero(_ error: String)
}
