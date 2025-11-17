//
//  PostCardViewModel.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation
import Observation

@Observable
final class PostCardViewModel {
    var isLiked = false
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func toggleLike() {
        isLiked.toggle()
    }
}
