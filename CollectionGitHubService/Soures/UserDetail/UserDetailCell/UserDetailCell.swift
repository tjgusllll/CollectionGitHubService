//
//  UserDetailCell.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 15/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class UserDetailCell: UICollectionViewCell {
    
    //MARK:- Constant
    private struct UI {
        static let basicMargin: CGFloat = 10
        static let itemImageSize: CGFloat = 150
        static let itemFont: UIFont = UIFont.systemFont(ofSize: 15)
    }
    
    //MARK:- UI Properties
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let userLogin: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    let userLocation: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    let userCompany: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    let userFollowers: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    let userFollowing: UILabel = {
        let label = UILabel()
        label.font = UI.itemFont
        return label
    }()
    
    
    
    //MARK:- Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(userImageView)
        addSubview(userLogin)
        addSubview(userName)
        addSubview(userLocation)
        addSubview(userCompany)
        addSubview(userFollowers)
        addSubview(userFollowing)
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(UI.itemImageSize)
            make.height.equalTo(userImageView.snp.width)
        }
        
        userLogin.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.trailing).offset(UI.basicMargin)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(userLogin.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.trailing).offset(UI.basicMargin)
        }
        
        userLocation.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.trailing).offset(UI.basicMargin)
        }
        
        userCompany.snp.makeConstraints { make in
            make.top.equalTo(userLocation.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.trailing).offset(UI.basicMargin)
        }
        
        userFollowers.snp.makeConstraints { make in
            make.top.equalTo(userCompany.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.trailing).offset(UI.basicMargin)
            make.bottom.equalTo(-UI.basicMargin)
        }
        
        userFollowing.snp.makeConstraints { make in
            make.top.equalTo(userCompany.snp.bottom).offset(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            make.bottom.equalTo(-UI.basicMargin)
        }
        
        
    }
    
    //MARK:- ConfigureUI
    func configureUserUI(with user: UserDetailModel) {
        guard let followers = user.followers else { return }
        guard let following = user.following else { return }
        
        userImageView.kf.setImage(with: user.avatar_url)
        userLogin.text = user.login
        userName.text = user.name
        userLocation.text = user.location
        userCompany.text = user.company
        userFollowers.text = "followers : \(followers)"
        userFollowing.text = "following : \(following)"
    }
    
}
