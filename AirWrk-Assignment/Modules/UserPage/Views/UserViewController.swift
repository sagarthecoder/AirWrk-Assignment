//
//  UserViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var publicReposLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var followingsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    let identifier = "Identifier"
    var user : User?
    var publicRepos : [UserPublicRepos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInfos()
        setupCollectionView()
    }
    
    func setupData(user : User?, publicRepos : [UserPublicRepos]) {
        self.user = user
        self.publicRepos = publicRepos
    }
    
    private func setUserInfos() {
        guard let user = user else {
            return
        }
        if let avatarUrlString = user.avatar_url, let avatarURl = URL(string: avatarUrlString) {
            imageView.sd_setImage(with: avatarURl)
        }
        userName.text = user.login ?? ""
        followersLabel.text = String(format: "followers : %d", user.followers)
        followingsLabel.text = String(format: "following : %d", user.following)
        publicReposLabel.text = String(format: "Public Repositories : %d", publicRepos.count)
        
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: RepositoriesCollectionViewCell.className, bundle: nil)
        nib.instantiate(withOwner: self)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UserViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        publicRepos.count
    }
}

extension UserViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RepositoriesCollectionViewCell
        if indexPath.item < publicRepos.count {
            let item = publicRepos[indexPath.item]
            cell.repositoryName.text = item.name ?? ""
        }
        return cell
    }
}

extension UserViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
