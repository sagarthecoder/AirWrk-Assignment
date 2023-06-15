//
//  Owner.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit

class Owner : Decodable {
    var login : String?
    var id : Int?
    
    enum CodingKeys : String, CodingKey {
        case login = "login"
        case id = "id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}
