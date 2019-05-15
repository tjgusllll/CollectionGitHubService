//
//  UserDetailViewController.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 15/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit
import SnapKit

class UserDetailViewController: UIViewController {
    
    //MARK:- UI Constant
    struct UI {
        static let basicMargin: CGFloat = 10
        static let cellInfoHeight: CGFloat = 150
        static let cellReposHeight: CGFloat = 90
        static let backColor = UIColor(red: 215/255, green: 240/255, blue: 254/255, alpha: 1)
    }
    
    //MARK:- UI Properties
    
    var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(UserDetailCell.self, forCellWithReuseIdentifier: "UserDetailCell")
        collectionview.register(UserRepositoryCell.self, forCellWithReuseIdentifier: "UserRepositoryCell")
        collectionview.backgroundColor = UI.backColor
        return collectionview
    }()
    
    //MARK:- Properties
    enum Section: Int {
        case userInfo = 0
        case userRepos = 1
        case totalCount = 2
    }
    
    var username: String?
    var userDetail = UserDetailModel()
    var userRepos: [UserRepositoryModel] = []
    let githubDetailService = GitHubService()
    
    //pagination
    var pageReposArr: [UserRepositoryModel] = []
    var page: Int = 1
    
    
    //MARK:- Initialize
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = userName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI() {
        guard let username = self.username else { return }
        githubUserDetail(username: username)
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        view.addSubview(collectionview)
        
        //SnapKit
        collectionview.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    //get User Detail Info
    func githubUserDetail(username: String) {
        githubDetailService.requestGithubUserDetail(name: username) { result in
            switch result {
            case .success(let response):
                self.userDetail = response
                self.githubUserRepos(username: username, page: self.page)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //get User Repository
    func githubUserRepos(username: String, page: Int) {
        githubDetailService.requestGitHubUserRepository(name: username, page: page) { result in
            switch result {
            case .success(let response):
                self.resetReposList(response)
                self.page += 1
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //response Pagination
    func resetReposList(_ response: [UserRepositoryModel]) {
        userRepos = response
        for repos in userRepos {
            pageReposArr.append(repos)
        }
        
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func loadMoreData(username: String?, page: Int) {
        guard let username = username else { return }
        githubUserRepos(username: username, page: page)
    }
    
}

extension UserDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.totalCount.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.userInfo.rawValue {
            return 1
        } else {
            return pageReposArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Section.userInfo.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
            cell.configureUserUI(with: self.userDetail)
            cell.backgroundColor = UI.backColor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserRepositoryCell", for: indexPath) as! UserRepositoryCell
            cell.configureReposUI(with: self.pageReposArr[indexPath.row])
            cell.backgroundColor = .white
            return cell
        }
    }
    
    //MARK:- Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = self.pageReposArr.count - 1
        if indexPath.row == lastItem {
            self.loadMoreData(username: self.username, page: self.page)
        }
    }
}

//ConllectionView Cell Size
extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == Section.userInfo.rawValue {
            return CGSize(width: self.collectionview.frame.width, height: UI.cellInfoHeight)
        } else {
            return CGSize(width: self.collectionview.frame.width, height: UI.cellReposHeight)
        }
    }
}

