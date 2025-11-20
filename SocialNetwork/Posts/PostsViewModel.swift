//
//  PostsViewModel.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation
import Observation
import SwiftData

@Observable
final class PostsViewModel {
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?
    
    @MainActor
    func loadPosts(modelContext: ModelContext) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedPosts = try await NetworkService.shared.fetchPosts()
            let cachedPosts = try? modelContext.fetch(FetchDescriptor<Post>())
            let cachedIds = Set(cachedPosts?.compactMap { $0.id } ?? [])
            
            for fetchedPost in fetchedPosts {
                guard let postId = fetchedPost.id else { continue }
                
                if let cachedPost = cachedPosts?.first(where: { $0.id == postId }) {
                    cachedPost.userId = fetchedPost.userId
                    cachedPost.title = fetchedPost.title
                    cachedPost.body = fetchedPost.body
                } else if !cachedIds.contains(postId) {
                    modelContext.insert(fetchedPost)
                }
            }
            
            try? modelContext.save()
            
            await loadFromCache(modelContext: modelContext)
        } catch {
            errorMessage = error.localizedDescription
            await loadFromCache(modelContext: modelContext)
        }
        
        isLoading = false
    }
    
    @MainActor
    private func loadFromCache(modelContext: ModelContext) async {
        let descriptor = FetchDescriptor<Post>(
            sortBy: [SortDescriptor(\.id, order: .forward)]
        )
        if let cachedPosts = try? modelContext.fetch(descriptor) {
            posts = cachedPosts
        }
    }
}
