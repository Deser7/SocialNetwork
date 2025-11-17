//
//  PostCardView.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 18.11.2025.
//

import SwiftUI

struct PostCardView: View {
    @State private var viewModel: PostCardViewModel
    
    init(post: Post) {
        _viewModel = State(initialValue: PostCardViewModel(post: post))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.post.title ?? "")
                .font(.headline)
            
            Text(viewModel.post.body ?? "")
                .font(.body)
                .foregroundStyle(.secondary)
            
            Button(action: {viewModel.isLiked.toggle()}) {
                Image(systemName: viewModel.isLiked ? "heart.fill" : "heart.fill")
                    .foregroundStyle(viewModel.isLiked ? .red : .secondary)
            }
        }
    }
}

#Preview {
    PostCardView(
        post: Post(
            userId: 1,
            id: 1,
            title: "Title",
            body: "qwertyuiopasdfghjklzxcvbnm"
        )
    )
}
