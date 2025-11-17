//
//  Post.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import Foundation

struct Post: Decodable, Identifiable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

extension Post {
    var avatarURL: URL? {
        userId.flatMap { URL(string: "https://picsum.photos/seed/user\($0)/100/100") }
    }
}
