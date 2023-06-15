//
//  Repositories.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit

class Repositories : Decodable {
    var items : [Repository] = []
    
    enum CodingKeys : String, CodingKey {
        case items = "items"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Repository].self, forKey: .items)
    }
}
