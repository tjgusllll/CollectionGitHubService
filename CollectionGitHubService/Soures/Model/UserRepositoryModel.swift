//
//  UserRepositoryModel.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 15/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Foundation

struct UserRepositoryModel: Codable {
    var name: String?
    var description: String?
    var stargazers_count: Int?
    var watchers_count: Int?
    var created_at: String?
}
