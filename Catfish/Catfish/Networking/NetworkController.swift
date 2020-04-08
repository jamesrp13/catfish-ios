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
    private let baseURL = URL(string: "https://www.google.com")!

    
    // MARK: - Lifecycle Methods
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Posts

    func createPost(post: CreatePost, completion: @escaping (Response<Post, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post")
        
        do {
            let resource = try URLResource<Post>.create(url: url, object: post, method: .post)
            completion(.success(Post.mocks.first!))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func getPosts(for instance: GameInstance, lastPost: Post?, completion: @escaping (Response<[Post], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("feed").appendingPathComponent(instance.id)
        // last_post is optional - will get newest items if not included, otherwise will get x posts older than last_post
        let queries = [
            URLQueryItem(name: "num_items", value: String(15)),
            URLQueryItem(name: "last_post", value: lastPost?.id)
        ]
        
        do {
            let resource = try URLResource<[Post]>.create(url: url, queries: queries, method: .post)
            completion(.success(Post.mocks))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func getPosts(for profile: Profile, lastPost: Post?, completion: @escaping (Response<[Post], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post")
        // last_post is optional - will get newest items if not included, otherwise will get x posts older than last_post
        let queries = [
            URLQueryItem(name: "profile_id", value: profile.id),
            URLQueryItem(name: "num_items", value: String(15)),
            URLQueryItem(name: "last_post", value: lastPost?.id)
        ]
        
        do {
            let resource = try URLResource<[Post]>.create(url: url, queries: queries, method: .post)
            completion(.success(Post.mocks))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Comments
    
    func getPagedComments(for post: Post, lastComment: Comment?, completion: @escaping (Response<[Comment], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("comment")
        let queries = [
            URLQueryItem(name: "post_id", value: post.id),
            URLQueryItem(name: "num_comments", value: String(15)),
            URLQueryItem(name: "last_comment", value: lastComment?.id)
        ]
        
        do {
            let resource = try URLResource<[Comment]>.create(url: url, queries: queries, method: .post)
            completion(.success(Comment.mocks))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func addComment(comment: CreateComment, completion: @escaping (Response<Comment, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("comment")
        
        do {
            let resource = try URLResource<Comment>.create(url: url, object: comment, method: .post)
            completion(.success(Comment.mocks.first!))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Reactions
    
    func addReaction(reaction: CreateReaction, completion: @escaping (Response<Reaction, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("post/react")
        
        do {
            let resource = try URLResource<Reaction>.create(url: url, object: reaction, method: .post)
            completion(.success(Reaction.mocks.first!))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }

    // MARK: - User
    
    func getCurrentUser(completion: @escaping (Response<User, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        
        do {
            let resource = try URLResource<User>.create(url: url)
            completion(.success(User.mock))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func createUser(user: User, completion: @escaping (Response<User, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("user")
        
        do {
            let resource = try URLResource<User>.create(url: url, object: user, method: .post)
            completion(.success(User.mock))
            //load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Profiles
    
    func createProfile(profile: CreateProfile, inGameInstance instance: GameInstance, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profile")
        
        let queries = [URLQueryItem(name: "inst_id", value: instance.id)]
        
        do {
            let resource = try URLResource<Profile>.create(url: url, queries: queries, object: profile, method: .post)
            completion(.success(Profile.mocks.first!))
            //        load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func updateProfile(profile: Profile, completion: @escaping (Response<Profile, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("profile")
        
        do {
            let resource = try URLResource<Profile>.create(url: url, object: profile, method: .patch)
            completion(.success(Profile.mocks.first!))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - GameInstance
    
    func getGameInstance(fromInviteCode code: String, completion: @escaping (Response<GameInstance, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("instance")
        let queries = [
            URLQueryItem(name: "invite_code", value: code)
        ]
        
        do {
            let resource = try URLResource<GameInstance>.create(url: url, queries: queries)
            completion(.success(GameInstance.mock))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func createGameInstance(gameInstance: CreateGameInstance, completion: @escaping (Response<GameInstance, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("instance")
        
        do {
            let resource = try URLResource<GameInstance>.create(url: url, object: gameInstance, method: .post)
            completion(.success(GameInstance.mock))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func listGameInstances(completion: @escaping (Response<[GameInstance], NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("instance")
        
        do {
            let resource = try URLResource<[GameInstance]>.create(url: url)
            completion(.success([GameInstance.mock]))
//            load(resource, completion: completion)
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch {
            completion(.failure(.unknown))
        }
    }

    // MARK: - Helper Methods

    private func load<T: URLResourceType>(_ resource: T, session: URLSession = URLSession.shared, completion: @escaping (Response<T.Model, NetworkError>) -> Void) {
        var request = resource.urlRequest
        
        createAuthHeaders { (response) in
            switch response {
            case .success(let headers):
                for header in headers {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
                
                session.dataTask(with: resource.urlRequest) { (data, response, error) in
                    completion(resource.responseHandler(data, response, error))
                }
                
            case .failure:
                completion(.failure(.unauthenticated))
            }
        }
    }
    
    func createAuthHeaders(completion: @escaping (Response<[String: String], AuthError>) -> Void) {
        authService.getToken { (response) in
            switch response {
            case .success(let token):
                completion(.success(["Authorization": "Bearer \(token)"]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // TODO: Create Image Upload method
}
