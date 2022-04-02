//
//  HeroListServices.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 01/04/22.
//

import Foundation

class HeroListServices: HeroListServicesProtocol {
    let session = URLSession.shared
    
    func execute(handler: @escaping(Result<Hero, HeroError>) -> Void) {
        let request: HomeRequest = .home
        
        if var baseUrl = URLComponents(string: request.baseURL) {
            baseUrl.query = request.path
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url)
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if httpResponse.statusCode == 200 {
                    do {
                        guard let jsonData = data else { return handler(.failure(.noProcessedData)) }
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(Hero.self, from: jsonData)
                        
                        handler(.success(responseData))
                    } catch let error {
                        handler(.failure(.error(error.localizedDescription)))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
