//
//  Request.swift
//  Dummy
//
//  Created by Sulay on 06/03/24.
//

import Foundation
import Combine

protocol DocsRequest {
    func loadDocs() async throws -> [Doc]
}

class DocsRetrivalRequest: DocsRequest {
    
    func loadDocs() async throws -> [Doc] {
        
        guard let url = URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=j5GCulxBywG3lX211ZAPkAB8O381S5SM") else {
            throw RequestError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.failed(description: "Request Failed.")
        }
        
        if response.statusCode == 401 {
            throw RequestError.unauthorized
        } else {
            
            do {
                let docResponse = try JSONDecoder().decode(DocumentResponse.self, from: data)
                return docResponse.response?.docs ?? []
            } catch {
                print(error)
                throw RequestError.decode(description: error.localizedDescription)
            }
        }
    }
    
    
}
