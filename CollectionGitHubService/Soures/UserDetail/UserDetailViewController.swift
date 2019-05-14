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
    
    
    //MARK:- UI Properties
    var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(UserDetailCell.self, forCellWithReuseIdentifier: "UserDetailCell")
        collectionview.register(UserRepositoryCell.self, forCellWithReuseIdentifier: "UserRepositoryCell")
        collectionview.backgroundColor = .white
        return collectionview
    }()
    
    //MARK:- Properties
    var username: String?
    
    
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
        
    }
}
