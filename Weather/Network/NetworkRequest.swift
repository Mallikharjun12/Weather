//
//  NetworkRequest.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation

enum HTTPMethod:String {
    case get = "GET"
}

protocol NetworkRequest {
    var baseUrl:String { get }
    var path:String { get }
    var method: HTTPMethod { get }
    var headers:[String:String]? { get }
    var parameters: Encodable? { get }
    var queryParams:[String:String]? { get }
}


extension NetworkRequest {
    
    var baseUrl:String {
        "https://api.weatherbit.io/v2.0/"
    }
    
    var headers:[String:String]? {
        return nil
    }
    
    var parameters: Encodable? {
        return nil
    }
    
    func urlRequest() throws -> URLRequest {
        
        var urlString = baseUrl + path
        
        if let params = queryParams {
            urlString += "?"
            for (key,value) in params {
                urlString += "\(key)=\(value)&"
            }
        }
        urlString.removeLast()
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            do {
                let jsonData = try JSONEncoder().encode(parameters)
                request.httpBody = jsonData
            } catch {
                throw NetworkError.encodingFailed(error)
            }
        }
        
        return request
    }
}
