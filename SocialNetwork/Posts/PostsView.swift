//
//  ContentView.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import SwiftData
import SwiftUI

struct PostsView: View {
    @State private var viewModel = PostsViewModel()
    @State private var showAlert = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.posts) { post in
                        PostCardView(post: post)
                    }
                }
            }
            .navigationTitle("Feed")
            .task {
                await viewModel.loadPosts(modelContext: modelContext)
            }
            .refreshable {
                await viewModel.loadPosts(modelContext: modelContext)
            }
            .alert("Error", isPresented: $showAlert) {
                Button("Refresh") {
                    Task {
                        await viewModel.loadPosts(modelContext: modelContext)
                    }
                }
                Button("OK", role: .cancel) {}
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
            .onChange(of: viewModel.errorMessage) { _, newValue in
                showAlert = newValue != nil
            }
        }
    }
}

#Preview {
    PostsView()
        .modelContainer(for: Post.self, inMemory: true)
}
