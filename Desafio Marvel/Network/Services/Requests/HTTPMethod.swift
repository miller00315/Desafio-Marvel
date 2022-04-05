//
//  HTTPMethod.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import Foundation

enum HTTPMethod: String {
    case post
    case put
    case get
    case delete
    case patch
    
    public var name: String {
        return rawValue.uppercased()
    }
}
