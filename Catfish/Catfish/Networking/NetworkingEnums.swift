//
//  NetworkingEnums.swift
//  Catfish
//
//  Created by James Pacheco on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case badDecode
    case badEncode
    case noData
    case invalidURL
    case unknown
    case badURL
    case serverError
    case notFound404
    case unauthenticated
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
