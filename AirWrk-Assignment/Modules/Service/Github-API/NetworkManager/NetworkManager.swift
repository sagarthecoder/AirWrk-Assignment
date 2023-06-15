//
//  NetworkManager.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/14/23.
//

import UIKit
import Moya

protocol Networkable : AnyObject {
    var provider : MoyaProvider<GithubApi> { get }
    func getSearchRepo(maxItemCount : Int, searchValue : String, completion : @escaping (([Repository])->Void))
    func getUserData(userName : String, completion : @escaping (User)->Void)
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<GithubApi>()
    
    func getSearchRepo(maxItemCount: Int, searchValue: String, completion: @escaping (([Repository]) -> Void)) {
        provider.request(.searchRepositories(maxCount: maxItemCount, searchValue: searchValue)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Repositories.self, from: response.data)
                    completion(results.items)
                } catch {
                    print("fetching search repo error = \(error.localizedDescription)")
                }
                break
            case let .failure(error):
                print("fetching search repo error = \(error.localizedDescription)")
            }
        }
    }
    
    func getUserData(userName: String, completion: @escaping (User) -> Void) {
        provider.request(.user(userName: userName)) { result in
            switch result {
            case let .success(response):
                do {
                    let user = try JSONDecoder().decode(User.self, from: response.data)
                    completion(user)
                } catch {
                    print("fetching User Data error = \(error.localizedDescription)")
                }
                break
            case let .failure(error):
                print("fetching User Data error = \(error.localizedDescription)")
            }
        }
    }
    

}
