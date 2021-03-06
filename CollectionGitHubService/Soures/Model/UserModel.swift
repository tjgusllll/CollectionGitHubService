//
//  UserModel.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    var id: Int?
    var avatar_url: URL?
    var login: String?
}
