//
//  Router.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    case userAll(since: Int)
    case userDetail(name: String)
    case userRepos(name: String, page: Int)
    
    static let baseURL = "https://api.github.com"
    
    
    var method: HTTPMethod {
        switch self {
        case .userAll:
            return .get
        case .userDetail:
            return .get
        case .userRepos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .userAll(_):
            return "/users"
        case .userDetail(let name):
            return "/users/\(name)"
        case .userRepos(let name, _):
            return "/users/\(name)/repos"
        }
    }
    
    
    //MARK:- URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .userAll(let since):
            let params: Parameters = ["since":since]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        case .userDetail(_):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case .userRepos(_ ,let page):
            let params: Parameters = ["page":page]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        default:
            break
        }
        
        return urlRequest
    }
}
