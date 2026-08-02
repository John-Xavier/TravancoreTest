//
//  UserService.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//
import Foundation

class UserService {
    
    static let shared = UserService()
    private init() {}
    let endPoint = "users"
    
    func getUsers() async throws -> [User]{
    
        guard let requestURL = URL(string: "\(AppConfig.baseURL)\(endPoint)") else { throw URLError(.badURL) }
        let (data,response) = try await URLSession.shared.data(from: requestURL)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([User].self, from: data)
        
    }
}
