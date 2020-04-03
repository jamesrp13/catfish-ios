//
//  URLPostableResources.swift
//  Catfish
//
//  Created by James Pacheco on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

struct URLPostableResource<T, U>: URLResourceType {
    var urlRequest: URLRequest
    
    var responseHandler: (Data?, URLResponse?, Error?) -> Response<T, NetworkError>
    
    init(url: URL, body: Data, method: HTTPMethod = .post, headers: [String: String]? = nil, responseHandler: @escaping (Data?, URLResponse?, Error?) -> Response<T, NetworkError>) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        
        self.responseHandler = responseHandler
    }
}

extension URLPostableResource where T: Decodable, U: Encodable {
    init(url: URL, object: U, method: HTTPMethod = .post, headers: [String: String]? = nil) throws {
        let encoder = JSONEncoder()
        let body = try encoder.encode(object)
        self.init(url: url, body: body, method: method, headers: headers) { (data, response, error) in
            if let error = error {
                return .failure(.serverError(error))
            }
            
            guard let data = data else {
                return .failure(.noData)
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch {
                return .failure(.badDecode)
            }
        }
    }
}
