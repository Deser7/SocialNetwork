//
//  Post.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import Foundation
import SwiftData

@Model
final class Post: Identifiable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var isLiked = false
    var likesCount = 0
    
    init(
        userId: Int?,
        id: Int?,
        title: String?,
        body: String?
    ) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

extension Post {
    convenience init(from dto: PostDTO) {
        self.init(
            userId: dto.userId,
            id: dto.id,
            title: dto.title,
            body: dto.body
        )
    }
    
    var avatarURL: URL? {
        userId.flatMap { URL(string: "https://picsum.photos/seed/user\($0)/100/100") }
    }
}
