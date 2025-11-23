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
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("Loading...")
                } else if viewModel.posts.isEmpty {
                    ContentUnavailableView(
                        "No Posts",
                        image: "tray",
                        description: Text("Pull to refresh")
                    )
                } else {
                    List(viewModel.posts) { post in
                        PostCardView(post: post)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Feed")
            .task { await loadPosts() }
            .refreshable { await loadPosts() }
            .alert("Error", isPresented: $showAlert) {
                Button("Refresh") { Task { await loadPosts() } }
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
            .onChange(of: viewModel.errorMessage) { _, newValue in
                showAlert = newValue != nil
            }
        }
    }
    
    private func loadPosts() async {
        await viewModel.loadPosts(modelContext: modelContext)
    }
}

#Preview {
    PostsView()
        .modelContainer(for: Post.self, inMemory: true)
}
