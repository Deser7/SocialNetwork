//
//  PostCardView.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import SwiftData
import SwiftUI

struct PostCardView: View {
    @State private var viewModel: PostCardViewModel
    @Environment(\.modelContext) private var modelContext
    
    init(post: Post) {
        _viewModel = State(initialValue: PostCardViewModel(post: post))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            AsyncImage(url: viewModel.post.avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .overlay {
                        Text("\(viewModel.post.userId ?? 0)")
                            .font(.caption)
                    }
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            Text(viewModel.post.title ?? "Title")
                .font(.headline)
            
            Text(viewModel.post.body ?? "Body")
                .font(.body)
                .foregroundStyle(.secondary)
            
            Button(action: { viewModel.toggleLike() }) {
                Image(systemName: "heart.fill")
                    .foregroundStyle(viewModel.post.isLiked ? .red : .secondary)
            }
            .buttonStyle(.plain)
        }
        .task {
            viewModel.setModelContext(modelContext)
        }
    }
}

#Preview {
    PostCardView(
        post: Post(
            userId: 1,
            id: 1,
            title: "Title",
            body: "BodyBodyBodyBodyBodyBodyBodyBody"
        )
    )
    .modelContainer(for: Post.self, inMemory: true)
}
