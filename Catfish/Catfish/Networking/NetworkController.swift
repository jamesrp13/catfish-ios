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

    func createPost(post: CreatePost, completion: @escaping (Response<Post, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post")
        
        guard let resource = try? URLResource<Post>.create(url: url, object: post, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
            
        load(resource, completion: completion)
    }
    
    func getPosts(for instance: GameInstance, lastPost: Post?, completion: @escaping (Response<[Post], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("feed").appendingPathComponent(instance.id)
        // last_post is optional - will get newest items if not included, otherwise will get x posts older than last_post
        let queries = [
            URLQueryItem(name: "num_items", value: String(15)),
            URLQueryItem(name: "last_post", value: lastPost?.id)
        ]
        
        guard let resource = try? URLResource<[Post]>.create(url: url, queries: queries, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func getPosts(for profile: Profile, lastPost: Post?, completion: @escaping (Response<[Post], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post")
        // last_post is optional - will get newest items if not included, otherwise will get x posts older than last_post
        let queries = [
            URLQueryItem(name: "profile_id", value: profile.id),
            URLQueryItem(name: "num_items", value: String(15)),
            URLQueryItem(name: "last_post", value: lastPost?.id)
        ]
        
        guard let resource = try? URLResource<[Post]>.create(url: url, queries: queries, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    // MARK: - Comments
    
    func getPagedComments(for post: Post, lastComment: Comment?, completion: @escaping (Response<[Comment], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("comment")
        let queries = [
            URLQueryItem(name: "post_id", value: post.id),
            URLQueryItem(name: "num_comments", value: String(15)),
            URLQueryItem(name: "last_comment", value: lastComment?.id)
        ]
        
        guard let resource = try? URLResource<[Comment]>.create(url: url, queries: queries, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func addComment(comment: CreateComment, completion: @escaping (Response<Comment, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("comment")
        
        guard let resource = try? URLResource<Comment>.create(url: url, object: comment, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    // MARK: - Reactions
    
    func addReaction(reaction: CreateReaction, completion: @escaping (Response<Reaction, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post/react")
        
        guard let resource = try? URLResource<Reaction>.create(url: url, object: reaction, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }

    // MARK: - User
    
    func getCurrentUser(completion: @escaping (Response<CurrentUser, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        
        guard let resource = try? URLResource<CurrentUser>.create(url: url, headers: createAuthHeaders()) else {
            completion(.failure(.badURL))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func createUser(user: CurrentUser, completion: @escaping (Response<CurrentUser, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        
        guard let resource = try? URLResource<CurrentUser>.create(url: url, object: user, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
            
        load(resource, completion: completion)
    }
    
    // MARK: - Profiles
    
    func createProfile(profile: CreateProfile, inGameInstance instance: GameInstance, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profile")
        
        let queries = [URLQueryItem(name: "inst_id", value: instance.id)]
        
        guard let resource = try? URLResource<Profile>.create(url: url, queries: queries, object: profile, method: .post, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
        
        load(resource, completion: completion)
    }
    
    func updateProfile(profile: Profile, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profile")
        
        guard let resource = try? URLResource<Profile>.create(url: url, object: profile, method: .patch, headers: createAuthHeaders()) else {
            completion(.failure(.badEncode))
            return
        }
        
        load(resource, completion: completion)
    }
    
    // MARK: - GameInstance
    
    func getGameInstance(fromInviteCode code: String, completion: @escaping (Response<GameInstance, NetworkError>) -> Void) {
        
    }
    
    func createGameInstance(gameInstance: CreateGameInstance, completion: @escaping (Response<GameInstance, NetworkError>) -> Void) {
        
    }
    
    func listGameInstances(completion: @escaping (Response<[GameInstance], NetworkError>) -> Void) {
        
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
    
    // TODO: Create Image Upload method
}
