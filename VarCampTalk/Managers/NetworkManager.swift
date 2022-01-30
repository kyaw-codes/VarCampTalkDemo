//
//  NetworkManager.swift
//  VarCampTalk
//
//  Created by Kyaw Zay Ya Lin Tun on 29/01/2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkManagerError: Error {
        
        case custom(error: Error)
        case invalidRequest
        case failedToDecode
        case failedToDownload
        case failedToConvertImage
    }
    
    // MARK: - Old callback based func
    func fetchUsers(_ completion: @escaping(Result<[User], NetworkManagerError>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.custom(error: error)))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    completion(.failure(.invalidRequest))
                    return
                }
                
                guard
                    let data = data,
                    let users = try? JSONDecoder().decode([User].self, from: data)
                else {
                    completion(.failure(.failedToDecode))
                    return
                }
                
                completion(.success(users))
            }
        }.resume()
    }
    
    // MARK: - Migrate callback based func into async with continuation
    func users() async throws -> [User] {
        typealias Continuation = CheckedContinuation<[User], Error>
        
        return try await withCheckedThrowingContinuation { (continuation: Continuation) in
            self.fetchUsers { result in
                switch result {
                case .success(let users):
                    continuation.resume(returning: users)
                case .failure(let err):
                    continuation.resume(throwing: err)
                }
            }
        }
    }
    
    // MARK: - New async/await api
    func todos() async throws -> [ToDo] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw NetworkManagerError.invalidRequest
              }
        
        let todos = try JSONDecoder().decode([ToDo].self, from: data)
        return todos
    }
    
    func comments() async throws -> [Comment] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw NetworkManagerError.invalidRequest
              }
        
        let comments = try JSONDecoder().decode([Comment].self, from: data)
        return comments
    }
    
    func comment(id: Int) async throws -> Comment? {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw NetworkManagerError.invalidRequest
              }
        
        let comment = try JSONDecoder().decode([Comment].self, from: data).first { $0.id == id}
        return comment
    }
    
    func downloadKittyImage(_ completion: @escaping (Result<UIImage, NetworkManagerError>) -> Void) {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.custom(error: error)))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                else {
                    completion(.failure(.invalidRequest))
                    return
                }
                
                guard
                    let data = data,
                    let kitty = try? JSONDecoder().decode([Kitty].self, from: data).first
                else {
                    completion(.failure(.failedToDecode))
                    return
                }
                
                
                do {
                    let kittyURL = URL(string: kitty.url)!
                    let imageData = try Data(contentsOf: kittyURL)
                    if let image = UIImage(data: imageData) {
                        completion(.success(image))
                    } else {
                        completion(.failure(.failedToConvertImage))
                    }
                } catch {
                    completion(.failure(.failedToDownload))
                    return
                }
                
                
//                completion(.success(users))
            }
        }.resume()
    }
    
    func downloadLongRunningTodos() async throws -> [ToDo] {
        try await Task.sleep(seconds: 3)
        return try await todos()
    }
    
    func downloadLongRunningComment() async throws -> [Comment] {
        try await Task.sleep(seconds: 4)
        return try await comments()
    }
}
