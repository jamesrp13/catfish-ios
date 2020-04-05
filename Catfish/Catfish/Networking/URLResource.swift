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
    
    static func create(url: URL, pathParameters: String? = nil, queries: [URLQueryItem]? = nil, body: Data? = nil, method: HTTPMethod = .get, headers: [String: String]? = nil, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Response<T, NetworkError>) throws -> URLResource<T> {
        
        var fullURL = url
        if let pathParameters = pathParameters {
            fullURL = url.appendingPathComponent(pathParameters)
        }
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queries
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        
        return URLResource<T>(urlRequest: urlRequest, responseHandler: responseHandler)
    }
}

extension URLResource where T: Decodable {
    static func create<Input: Encodable>(url: URL, pathParameters: String? = nil, queries: [URLQueryItem]? = nil, object: Input? = nil, method: HTTPMethod = .get, headers: [String: String]? = nil) throws -> URLResource<T> {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let body = try encoder.encode(object)
        
        return try URLResource<T>.create(url: url, pathParameters: pathParameters, queries: queries, body: body, method: method, headers: headers)
    }
    
    static func create(url: URL, pathParameters: String? = nil, queries: [URLQueryItem]? = nil, body: Data? = nil, method: HTTPMethod = .get, headers: [String: String]? = nil) throws -> URLResource<T> {
        return try URLResource<T>.create(url: url, pathParameters: pathParameters, queries: queries, body: body, method: method, headers: headers) { (data, response, error) in
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
