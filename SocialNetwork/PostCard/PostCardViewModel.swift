//
//  PostCardViewModel.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation
import Observation
import SwiftData

@Observable
final class PostCardViewModel {
    let post: Post
    private var modelContext: ModelContext?
    
    init(post: Post, modelContext: ModelContext? = nil) {
        self.post = post
        self.modelContext = modelContext
    }
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func toggleLike() {
        post.isLiked.toggle()
        try? modelContext?.save()
    }
}
