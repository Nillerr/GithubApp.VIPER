//
//  Api.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import Moya
import ReactiveMoya

enum Github {
    case repositories
    case repo(fullName: String)
}

extension Github: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .repositories:
            return "/repositories"
        case .repo(let fullName):
            return "/repos/\(fullName)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .repositories, .repo(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .repositories, .repo(_):
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return [ "Content-Type": "application/json" ]
    }
}

struct RepositoryListItem: Codable {
    let id: Int
    let name: String
    let fullName: String
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case htmlUrl = "html_url"
    }
}

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
    }
}
