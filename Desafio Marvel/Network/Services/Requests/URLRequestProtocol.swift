//
//  URLRequestProtocol.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import Foundation

protocol URLRequestProtocol {
    /// The API base url
    var baseURL: String { get }
    
    /// Defines the endpoint we want to hit
    var path: String { get }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod { get }
    
}
