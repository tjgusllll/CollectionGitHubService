//
//  ViewController.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 13/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit
import SnapKit

class AllUserViewController: UIViewController {
    
    //MARK:- UI Constant
    
    struct UI {
        static let basicMargin: CGFloat = 10
    }
    
    
    //MARK:- UI Properties
    
    var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(AllUserCell.self, forCellWithReuseIdentifier: "AllUserCell")
        collectionview.backgroundColor = .white
        return collectionview
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK:- Properties
    
    var users: [UserModel] = []
    let githubService = GitHubService()
    //pagination
    var pageArr: [UserModel] = []
    enum Pagenation: Int {
        case pagelimit = 20
        case pageFirstLoad = 0
    }
    //searchController
    var searchResult: [UserModel] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        //searchController
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Name"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        //CollectionView
        collectionview.dataSource = self
        collectionview.delegate = self
        view.addSubview(collectionview)
        
        //SnapKit
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(UI.basicMargin)
            make.leading.equalTo(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            make.bottom.equalTo(-UI.basicMargin)
        }
        
        //getAllUserList
        githubGetAll(since: Pagenation.pageFirstLoad.rawValue)
    }
    
    func githubGetAll(since: Int) {
        githubService.requestGitHubAllUser(since: since) { result in
            switch result {
            case .success(let response):
                self.resetUserList(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //response pagination
    func resetUserList(_ response: [UserModel]) {
        users = response
        for i in 0..<Pagenation.pagelimit.rawValue {
            pageArr.append(users[i])
        }
        
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    //load more data for pagination
    func loadMoreData(since: Int?) {
        guard let lastID = since else { return }
        githubGetAll(since: lastID)
    }
    
}


extension AllUserViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? searchResult.count : self.pageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userdata = searchController.isActive ? searchResult[indexPath.row] : pageArr[indexPath.row]
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "AllUserCell", for: indexPath) as! AllUserCell
        //cell.configure(with: pageArr[indexPath.row])
        cell.configure(with: userdata)
        return cell
    }
    
    //MARK:- Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = self.pageArr.count - 1
        if indexPath.row == lastItem {
            self.loadMoreData(since: pageArr[indexPath.row].id)
        }
    }
    
    //MARK:- DetailUser Navigation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userdata = searchController.isActive ? searchResult[indexPath.row] : pageArr[indexPath.row]
        guard let userName = userdata.login else { return }
        let detailVC = Navigator.detailUser(name:userName).viewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//ConllectionView Cell Size
extension AllUserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (self.collectionview.frame.width - UI.basicMargin) / 2
        let cellheight = cellwidth + (UI.basicMargin * 3)
        return CGSize(width: cellwidth, height: cellheight )
    }
}


extension AllUserViewController: UISearchResultsUpdating {
    //MARK:- UISearchUpdating Method
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            collectionview.reloadData()
        }
    }
    
    func filterContent(for searchText: String) {
        searchResult = pageArr.filter({ (UserModel) -> Bool in
            let match = UserModel.login?.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
}

