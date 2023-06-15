//
//  RepositoryDetailViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit
import SDWebImage

class RepositoryDetailViewController: UIViewController {
    
    var repository : Repository?
    var user : User?
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var totalOpenIssues: UILabel!
    @IBOutlet weak var totalFork: UILabel!
    @IBOutlet weak var totolStar: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setRepoDetail()
        setUserDetail()
    }
    
    func setupData(repository : Repository?, user : User?) {
        self.repository = repository
        self.user = user
    }
    
    private func setRepoDetail() {
        guard let repository = repository else {
            return
        }
        repositoryNameLabel.text = repository.name ?? ""
        descriptionLabel.text = repository.description ?? ""
        totolStar.text = String(repository.startCount)
        totalFork.text = String(repository.forks_count)
        totalOpenIssues.text = String(repository.open_issues_count)
    }
    
    private func setUserDetail() {
        guard let user = user else {
            return
        }
        if let avatarUrlString = user.avatar_url, let avatarURL = URL(string: avatarUrlString) {
            imageView.sd_setImage(with: avatarURL)
        }
        userName.text = user.login ?? ""
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func userButtonAction(_ sender: UIButton) {
        guard let user = user, let username = user.login else {
            return
        }
        NetworkManager.shared.getUserPublicRepos(userName: username) { publicRepos in
            DispatchQueue.main.async { [self] in
                let userVC = UserViewController()
                userVC.setupData(user: user, publicRepos: publicRepos)
                self.navigationController?.pushViewController(userVC, animated: true)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
