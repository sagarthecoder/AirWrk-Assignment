//
//  User.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit

class User : Decodable {
    var login : String?
    var id : Int?
    var avatar_url : String?
    var html_url : String?
    var name : String?
    var public_repos : Int
    var followers : Int
    var following : Int
    
    enum CodingKeys : String, CodingKey {
        case login = "login"
        case id = "id"
        case avatar_url = "avatar_url"
        case html_url = "html_url"
        case name = "name"
        case public_repos = "public_repos"
        case followers = "followers"
        case following = "following"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url)
        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.public_repos = try container.decode(Int.self, forKey: .public_repos)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
    }
}
