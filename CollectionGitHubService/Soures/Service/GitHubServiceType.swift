//
//  GitHubServiceType.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Alamofire

protocol GitHubServiceType {
    func requestGitHubAllUser(since: Int, completion: @escaping (Result<[UserModel]>) -> ())
    func requestGithubUserDetail(name: String, completion: @escaping (Result<UserDetailModel>) -> ())
    func requestGitHubUserRepository(name: String, page: Int, completion: @escaping (Result<[UserRepositoryModel]>) -> ())
}
