//
//  ViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit
import Moya
class ViewController: UIViewController {
     var networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getSearchRepo(maxItemCount: 4, searchValue: "Crop", completion: { repositories in
            print("all repos = \(repositories)")

        })
//        networkManager.getUserData(userName: "sagarthecoder") { user in
//
//        }
    }


}

