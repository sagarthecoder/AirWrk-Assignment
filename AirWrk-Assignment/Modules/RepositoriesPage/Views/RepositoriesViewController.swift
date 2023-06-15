//
//  RepositoriesViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = RepositoriesCollectionViewCell.className//String(describing: RepositoriesCollectionViewCell.self)
    var repositories = [Repository]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupData(repositories : [Repository]) {
        self.repositories = repositories
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

extension RepositoriesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        repositories.count
    }
}

extension RepositoriesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RepositoriesCollectionViewCell
        if indexPath.item < repositories.count {
            let item = repositories[indexPath.item]
            cell.repositoryName.text = item.full_name ?? ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < repositories.count {
            let repository = repositories[indexPath.item]
            if let username = repository.owner?.login {
                NetworkManager.shared.getUserData(userName: username) { user in
                    DispatchQueue.main.async { [self] in
                        let repoDetailVC = RepositoryDetailViewController()
                        repoDetailVC.setupData(repository: repository, user: user)
                        self.navigationController?.pushViewController(repoDetailVC, animated: true)
                    }
                }
            }
        }
    }
}

extension RepositoriesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
