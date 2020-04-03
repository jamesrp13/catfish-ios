//
//  NetworkController.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

class NetworkController {

    // MARK: - Properties

    private let authService: AuthServiceProtocol
    private let baseURL = URL(string: "URL HERE!!!")!

    
    // MARK: - Lifecycle Methods
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Posts

    func createPost(post: Post, completion: @escaping (Response<Bool, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post")
        guard let resource = try? URLPostableResource<Bool, Post>(url: url, object: post, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
            
        load(resource, completion: completion)
    }
    
    func getPosts(for instance: GameInstance, completion: @escaping (Response<[Post], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("posts")
        let queries = [URLQueryItem(name: "instanceID", value: instance.id)]
        guard let resource = try? URLResource<[Post]>(url: url, queries: queries, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }

    // MARK: - User
    
    func getUser(completion: @escaping (Response<User, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        guard let resource = try? URLResource<User>(url: url, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func createUser(user: User, completion: @escaping (Response<Bool, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        guard let resource = try? URLPostableResource<Bool, User>(url: url, object: user, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
            
        load(resource, completion: completion)
    }
    
    // MARK: - Profile
    
    func getProfiles(for instance: GameInstance, completion: @escaping (Response<[Profile], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profiles")
        let queries = [URLQueryItem(name: "instanceID", value: instance.id)]
        guard let resource = try? URLResource<[Profile]>(url: url, queries: queries, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func getProfile(forID id: String, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profiles")
        let queries = [URLQueryItem(name: "id", value: id)]
        guard let resource = try? URLResource<Profile>(url: url, queries: queries, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func createProfile(profile: CreateProfile, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profile")
        guard let resource = try? URLPostableResource<Profile, CreateProfile>(url: url, object: profile, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
        
        load(resource, completion: completion)
    }
    
    // MARK: - Comment
    
    func createComment(comment: CreateComment, completion: @escaping (Response<Comment, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("comment")
        guard let resource = try? URLPostableResource<Comment, CreateComment>(url: url, object: comment, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
        
        load(resource, completion: completion)
    }
    
    // MARK: - Reaction
    
    func addReaction(_ reaction: CreateReaction, toPost post: Post, completion: @escaping (Response<Reaction, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("reaction")
        guard let resource = try? URLPostableResource<Reaction, CreateReaction>(url: url, object: reaction, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
        
        load(resource, completion: completion)
    }

    // MARK: - Helper Methods

    private func load<T: URLResourceType>(_ resource: T, session: URLSession = URLSession.shared, completion: @escaping (Response<T.Model, NetworkError>) -> Void) {
        session.dataTask(with: resource.urlRequest) { (data, response, error) in
            completion(resource.responseHandler(data, response, error))
        }
    }
    
    func createAuthHeaders() -> [String: String] {
        fatalError("Not implemented")
    }
}
