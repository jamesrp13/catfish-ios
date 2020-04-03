//
//  URLResource.swift
//  Catfish
//
//  Created by James Pacheco on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

struct URLResource<T>: URLResourceType {
    
    var urlRequest: URLRequest
    
    var responseHandler: (Data?, URLResponse?, Error?) -> Response<T, NetworkError>
    
    init(url: URL, pathParameters: String? = nil, queries: [URLQueryItem]? = nil, method: HTTPMethod = .get, headers: [String: String]? = nil, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Response<T, NetworkError>) throws {
        self.responseHandler = responseHandler
        
        var fullURL = url
        if let pathParameters = pathParameters {
            fullURL = url.appendingPathComponent(pathParameters)
        }
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queries
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
    }
}

extension URLResource where T: Decodable {
    init(url: URL, pathParameters: String? = nil, queries: [URLQueryItem]? = nil, method: HTTPMethod = .get, headers: [String: String]? = nil) throws {
        try self.init(url: url, pathParameters: pathParameters, queries: queries, method: method, headers: headers) { (data, response, error) in
            if let error = error {
                return .failure(.serverError(error))
            }
            
            guard let data = data else {
                return .failure(.noData)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch {
                return .failure(.badDecode)
            }
        }
    }
}
