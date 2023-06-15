//
//  HomeViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var visualEffectView : UIVisualEffectView?
    var activityIndicator : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
}

extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            showVisualEffectView()
            showActivityIndicator()
            NetworkManager.shared.getSearchRepo(maxItemCount: 50, searchValue: text) { repositories in
                DispatchQueue.main.async { [self] in
                    let repositoriesVC = RepositoriesViewController()
                    repositoriesVC.setupData(repositories: repositories)
                    stopAnimating()
                    hideVisualEffectView()
                    self.navigationController?.pushViewController(repositoriesVC, animated: true)
                    searchBar.text = ""
                }
            }
        }
    }
}

extension HomeViewController {
    private func showVisualEffectView() {
        if visualEffectView == nil {
            addVisualEffectView()
        }
        guard let visualEffectView = visualEffectView else {
            return
        }
        visualEffectView.isHidden = false
        view.bringSubviewToFront(visualEffectView)
    }
    
    private func addVisualEffectView() {
        let blurEffect = UIBlurEffect(style: .dark)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = view.bounds
        guard let visualEffectView = visualEffectView else {
            return
        }
        view.addSubview(visualEffectView)
    }
    
    private func hideVisualEffectView() {
        guard let visualEffectView = visualEffectView else {
            return
        }
        view.sendSubviewToBack(visualEffectView)
        visualEffectView.isHidden = true
    }
}

extension HomeViewController {
    private func showActivityIndicator() {
        if activityIndicator == nil {
            addActivityIndicator()
        }
        guard let activityIndicator = activityIndicator else {
            return
        }
        view.bringSubviewToFront(activityIndicator)
        startAnimating()
    }
    
    private func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .white
        activityIndicator?.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        activityIndicator?.center = view.center
        guard let activityIndicator = activityIndicator else {
            return
        }
        view.addSubview(activityIndicator)
    }
    
    private func startAnimating() {
        activityIndicator?.startAnimating()
    }
    
    private func stopAnimating() {
        activityIndicator?.stopAnimating()
    }

    
}
