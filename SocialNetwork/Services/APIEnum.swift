//
//  APIEnum.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation

enum APIEnum {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let postsURL = URL(string: "\(baseURL)/posts")
    
    static func avatarURL(for userId: Int) -> URL? {
        URL(string: "https://api.dicebear.com/7.x/avataaars/png?seed=\(userId)&size=100&backgroundColor=b6e3f4")
    }
}
