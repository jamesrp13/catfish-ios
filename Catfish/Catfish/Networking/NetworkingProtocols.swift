//
//  NetworkingProtocols.swift
//  Catfish
//
//  Created by James Pacheco on 4/2/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

protocol URLResourceType {
    associatedtype Model
    
    var urlRequest: URLRequest { get }
    
    var responseHandler: (Data?, URLResponse?, Error?) -> Response<Model, NetworkError> { get }
}
