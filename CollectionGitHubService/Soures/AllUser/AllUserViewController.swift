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
    
    //MARK:- UI Properties
    
    struct UI {
        static let basicMargin: CGFloat = 10
    }
    
    var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(AllUserCell.self, forCellWithReuseIdentifier: "AllUserCell")
        collectionview.backgroundColor = .white
        return collectionview
    }()
    
    
    //MARK:- Properties
    
    var users: [UserModel] = []
    let githubService = GitHubService()
    //pagination
    var pageArr: [UserModel] = []
    let limit: Int = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        //Navigation LargeTitle UI
        self.title = "GitHubService"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
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
        githubGetAll(since: 0)
    }
    
    func githubGetAll(since: Int) {
        githubService.requestGitHubSericeAllUser(since: since) { result in
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
        for i in 0..<limit {
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
        return self.pageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "AllUserCell", for: indexPath) as! AllUserCell
        cell.configure(with: pageArr[indexPath.row])
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
        guard let userName = self.pageArr[indexPath.row].login else { return }
        let detailVC = ProvideObject.detailUser(name:userName).viewController
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
