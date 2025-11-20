//
//  PostDTO.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 19.11.2025.
//

import Foundation

struct PostDTO: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
