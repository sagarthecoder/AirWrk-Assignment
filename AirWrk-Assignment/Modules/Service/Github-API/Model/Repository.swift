//
//  Repository.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit

class Repository : Decodable {
    var id : Int?
    var name : String?
    var full_name : String?
    var isPrivate : Bool
    var owner : Owner?
    var html_url : String?
    var description : String?
    var forks_count : Int
    var open_issues_count : Int
    var startCount : Int
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case full_name = "full_name"
        case isPrivate = "private"
        case owner = "owner"
        case html_url = "html_url"
        case description = "description"
        case forks_count = "forks_count"
        case open_issues_count = "open_issues_count"
        case starCount = "stargazers_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
        self.owner = try container.decodeIfPresent(Owner.self, forKey: .owner)
        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.forks_count = try container.decode(Int.self, forKey: .forks_count)
        self.open_issues_count = try container.decode(Int.self, forKey: .open_issues_count)
        self.startCount = try container.decode(Int.self, forKey: .starCount)

    }
}
