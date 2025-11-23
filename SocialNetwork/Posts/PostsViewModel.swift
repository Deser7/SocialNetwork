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
        defer { isLoading = false }
        
        do {
            let fetchedPosts = try await NetworkService.shared.fetchPosts()
            syncPosts(fetchedPosts, with: modelContext)
            try modelContext.save()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        await loadFromCache(modelContext: modelContext)
    }
    
    @MainActor
    private func loadFromCache(modelContext: ModelContext) async {
        let descriptor = FetchDescriptor<Post>(
            sortBy: [SortDescriptor(\.id, order: .forward)]
        )
        
        do {
            posts = try modelContext.fetch(descriptor)
        } catch {
            print("Ошибка загрузки из кэша: \(error.localizedDescription)")
            posts = []
        }
    }
    
    private func syncPosts(_ fetchedPosts: [Post], with context: ModelContext) {
        let cachedPosts = (try? context.fetch(FetchDescriptor<Post>())) ?? []
        let cachedPostsDictionary = Dictionary(
            uniqueKeysWithValues: cachedPosts.compactMap { post -> (Int, Post)? in
                guard let id = post.id else { return nil }
                return (id, post)
            }
        )
        
        for fetchedPost in fetchedPosts {
            guard let postId = fetchedPost.id else { continue }
            
            if let cachedPost = cachedPostsDictionary[postId] {
                cachedPost.userId = fetchedPost.userId
                cachedPost.title = fetchedPost.title
                cachedPost.body = fetchedPost.body
            } else {
                context.insert(fetchedPost)
            }
        }
    }
}
