//
//  Comment.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
    
    /// Async Property
    static var fetchAll: [Comment] {
        get async throws {
            return try await NetworkManager.shared.comments()
        }
    }
}

/*
 
 */
