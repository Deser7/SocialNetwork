//
//  PostsViewModel.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import Foundation
import Observation

@Observable
final class PostsViewModel {
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?
    
    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            posts = try await NetworkService.shared.fetchPosts()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
