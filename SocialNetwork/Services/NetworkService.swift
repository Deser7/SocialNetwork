//
//  NetworkService.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw URLError(.badURL)
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce = responce as? HTTPURLResponse,
              (200..<300).contains(httpResponce.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
