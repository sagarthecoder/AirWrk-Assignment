//
//  GithubApi.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit
import Moya

enum GithubApi {
    case searchRepositories(maxCount : Int = 5, searchValue : String)
    case user(userName : String)
    case publicRepos(userName : String)
}


extension GithubApi : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
            
        case .searchRepositories(_ , _):
            return "/search/repositories"
        case .user(userName: let userName):
            return "/users/\(userName)"
        case .publicRepos(userName: let userName):
            return "/users/\(userName)/repos"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
            
        case .searchRepositories(maxCount: let maxCount, searchValue: let searchValue):
            return .requestParameters(parameters: ["q" : searchValue, "per_page" : maxCount], encoding: URLEncoding.queryString)
        case .user(_), .publicRepos(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
        // return ["Content-type": "application/vnd.github+json"]
    }
    
    
}
