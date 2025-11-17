//
//  ContentView.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import SwiftUI

struct PostsView: View {
    @State private var viewModel = PostsViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                PostCardView(post: post)
            }
            .navigationTitle("Feed")
            .task {
                await viewModel.loadPosts()
            }
            .refreshable {
                await viewModel.loadPosts()
            }
            .alert("Error", isPresented: $showAlert) {
                Button("Refresh") {
                    Task {
                        await viewModel.loadPosts()
                    }
                }
                Button("OK", role: .cancel) {}
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    PostsView()
}
