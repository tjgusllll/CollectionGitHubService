//
//  AllUserCell.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class AllUserCell: UICollectionViewCell{
    
    //MARK:- Constant
    
    private struct UI {
        static let basicMargin: CGFloat = 10
        static let itemImageSize: CGFloat = 100
        static let loginFont: UIFont = UIFont.boldSystemFont(ofSize: 20)
        static let idFont: UIFont = UIFont.systemFont(ofSize: 15)
    }
    
    
    //MARK:- UI Properties
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UI.idFont
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UI.loginFont
        return label
    }()
    
    
    //MARK:- Properties
    
    
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
        addSubview(idLabel)
        addSubview(loginLabel)
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(UI.basicMargin)
            make.leading.equalTo(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            //make.size.greaterThanOrEqualTo(CGSize(width: UI.itemmageSize, height: UI.itemImageSize))
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(userImageView.snp.leading)
            make.bottom.equalTo(-UI.basicMargin)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            make.bottom.equalTo(-UI.basicMargin
            )
        }
    }
    
    
    func configure(with user: UserModel) {
        guard let id = user.id else { return }
        userImageView.kf.setImage(with: user.avatar_url)
        loginLabel.text = user.login
        idLabel.text = String(id)
    }
    
    
}
