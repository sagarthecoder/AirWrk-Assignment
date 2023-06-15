//
//  HomeViewController.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/15/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var visualEffectView : UIVisualEffectView?
    var activityIndicator : UIActivityIndicatorView?
    var presenter = HomePagePresenter()
    let identifier = "TableIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tableView != nil {
            tableView.reloadData()
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: TableViewCell.className, bundle: nil)
        nib.instantiate(withOwner: self)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    private func gotoRepositoriesPage(searchedText text : String?) {
        guard let text = text else {
            return
        }
        
        showVisualEffectView()
        showActivityIndicator()
        if presenter.numberOfCachedText() < presenter.maxCacheTextLImit() {
            presenter.saveNewTextToDB(text: text)
        } else if let lastItemID = presenter.getItemAt(index: presenter.numberOfCachedText() - 1)?.id {
            presenter.deleteTextFromDB(id: lastItemID) {
                self.presenter.saveNewTextToDB(text: text)
            }
            
        }
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
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

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCachedText()
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TableViewCell
        if let text = presenter.getItemAt(index: indexPath.row)?.text {
            cell.searchtextTabel.text = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let text = presenter.getItemAt(index: indexPath.row)?.text {
            gotoRepositoriesPage(searchedText: text)
        }
    }
}


extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
           gotoRepositoriesPage(searchedText: text)
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
