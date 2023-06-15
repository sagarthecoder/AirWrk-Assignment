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
    func getUserData(userName : String, completion : @escaping (User?)->Void)
    func getUserPublicRepos(userName : String, completion : @escaping ([UserPublicRepos])->Void)
}

final class NetworkManager: Networkable {
    private init() {}
    static let shared = NetworkManager()
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
                    completion([])
                }
                break
            case let .failure(error):
                print("fetching search repo error = \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    func getUserData(userName: String, completion: @escaping (User?) -> Void) {
        provider.request(.user(userName: userName)) { result in
            switch result {
            case let .success(response):
                do {
                    let user = try JSONDecoder().decode(User.self, from: response.data)
                    completion(user)
                } catch {
                    print("fetching User Data error = \(error.localizedDescription)")
                    completion(nil)
                }
                break
            case let .failure(error):
                print("fetching User Data error = \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func getUserPublicRepos(userName: String, completion: @escaping ([UserPublicRepos]) -> Void) {
        provider.request(.publicRepos(userName: userName)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([UserPublicRepos].self, from: response.data)
                    completion(results)
                } catch {
                    print("fetching User Public repos Data error = \(error.localizedDescription)")
                    completion([])
                }
                break
            case let .failure(error):
                print("fetching User Public repos Data error = \(error.localizedDescription)")
                completion([])
            }
        }
    }
    

}
