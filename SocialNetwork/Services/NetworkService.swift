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
    
    func fetchPosts() async throws -> [Post] {
        guard let url = APIEnum.postsURL else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let dtos = try JSONDecoder().decode([PostDTO].self, from: data)
        return dtos.map { Post(from: $0)}
    }
}
