//
//  UserRepositoryCell.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 15/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit
import SnapKit

final class UserRepositoryCell: UICollectionViewCell {
    
    //MARK:- Constant
    private struct UI {
        static let basicMargin: CGFloat = 10
        static let basicFont: UIFont = UIFont.systemFont(ofSize: 15)
        static let descriptionWidth: CGFloat = 250
    }
    
    //MARK:- UI Properties
    let reposName: UILabel = {
        let label = UILabel()
        label.font = UI.basicFont
        return label
    }()
    
    let reposDate: UILabel = {
        let label = UILabel()
        label.font = UI.basicFont
        return label
    }()
    
    let reposStar: UILabel = {
        let label = UILabel()
        label.font = UI.basicFont
        return label
    }()
    
    let reposWatcher: UILabel = {
        let label = UILabel()
        label.font = UI.basicFont
        return label
    }()
    
    let reposDescription: UILabel = {
        let label = UILabel()
        label.font = UI.basicFont
        label.textAlignment = .natural
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 2
        return label
    }()
    
    
    
    //MARK: Inatializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(reposName)
        addSubview(reposDate)
        addSubview(reposStar)
        addSubview(reposWatcher)
        addSubview(reposDescription)
        
        reposName.snp.makeConstraints { make in
            make.top.equalTo(UI.basicMargin)
            make.leading.equalTo(UI.basicMargin)
        }
        
        reposDescription.snp.makeConstraints { make in
            make.top.equalTo(reposName.snp.bottom).offset(UI.basicMargin)
            make.leading.equalTo(UI.basicMargin)
            make.width.lessThanOrEqualTo(UI.descriptionWidth)
        }
        
        reposStar.snp.makeConstraints { make in
            make.top.equalTo(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            make.leading.greaterThanOrEqualTo(reposName.snp.trailing).offset(UI.basicMargin)
        }
        
        reposWatcher.snp.makeConstraints { make in
            make.top.equalTo(reposStar.snp.bottom).offset(UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            //make.leading.equalTo(reposDescription.snp.trailing).offset(UI.basicMargin)
        }
        
        
        reposDate.snp.makeConstraints { make in
            make.top.equalTo(reposWatcher.snp.bottom).offset(UI.basicMargin)
            make.bottom.equalTo(-UI.basicMargin)
            make.trailing.equalTo(-UI.basicMargin)
            //make.leading.greaterThanOrEqualTo(reposDescription.snp.trailing).offset(UI.basicMargin)
        }
        
    }
    
    func configureReposUI(with repos: UserRepositoryModel) {
        guard let stars = repos.stargazers_count else { return }
        guard let watchers = repos.watchers_count else { return }
        guard let created = repos.created_at else { return }
        
        reposName.text = repos.name
        reposDescription.text = repos.description
        reposStar.text = "star : \(stars)"
        reposWatcher.text = "watcher : \(watchers)"
        reposDate.text = dateConverter(created: created)
        
        
    }
    
    func dateConverter(created: String) -> String? {
        var result: String?
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: created)
        
        if let dateStr = date {
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            result = formatter.string(from: dateStr)
        }
        return result
    }
    
}
