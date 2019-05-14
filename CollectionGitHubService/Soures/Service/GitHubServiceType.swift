//
//  GitHubServiceType.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Alamofire

protocol GitHubServiceType {
    func requestGitHubSericeAllUser(since: Int, completion: @escaping (Result<[UserModel]>) -> ())
}
