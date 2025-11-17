//
//  Post.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import Foundation

struct Post: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
