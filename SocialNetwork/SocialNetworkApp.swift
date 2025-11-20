//
//  SocialNetworkApp.swift
//  SocialNetwork
//
//  Created by Наташа Спиридонова on 17.11.2025.
//

import SwiftData
import SwiftUI

@main
struct SocialNetworkApp: App {
    var body: some Scene {
        WindowGroup {
            PostsView()
        }
        .modelContainer(for: Post.self)
    }
}
