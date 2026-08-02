//
//  Service.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import Foundation

class Service{
    let url = "https://66b771b37f7b1c6d8f1be8d4.mockapi.io/"
    
    init(){
        let shared = Service()
    }
    
    func networkCall(endPoint: String) async throws{
        guard let requestURL = URL(string: "\(url)\(endPoint)") else { throw URLError(.badURL) }
        let (data,response) = try await URLSession.shared.data(from: requestURL)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
    }
}
