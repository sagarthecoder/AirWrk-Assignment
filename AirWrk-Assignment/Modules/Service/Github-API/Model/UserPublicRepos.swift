//
//  UserPublicRepos.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit

class UserPublicRepos: Decodable {
    var name : String?
    var full_name : String?
    var html_url : String?
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case full_name = "full_name"
        case html_url = "html_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
    }
}
