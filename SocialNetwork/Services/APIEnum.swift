//
//  APIEnum.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation

enum APIEnum {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    static var postsURL: URL? {
        URL(string: "\(baseURL)/posts")
    }
}
