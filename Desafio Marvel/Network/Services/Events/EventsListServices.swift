//
//  EventListServices.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//

import Foundation

class EventListServices: EventsListServicesProtocol {
    let session = URLSession.shared
    
    func execute(id: Int, handler: @escaping (Result<Events, EventError>) -> Void) {
        let request: HomeRequest = .events
        let eventsUrl = "\(request.baseURL)" + "/\(id)/events"
        
        if var eventUrl = URLComponents(string: eventsUrl) {
            eventUrl.query = request.path
            guard let url = eventUrl.url else { return }
            
            var requestUrl = URLRequest(url: url)
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if httpResponse.statusCode == 200 {
                    do {
                        guard let jsonData = data else { return handler(.failure(.noProcessedData)) }
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(Events.self, from: jsonData)
                        
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
