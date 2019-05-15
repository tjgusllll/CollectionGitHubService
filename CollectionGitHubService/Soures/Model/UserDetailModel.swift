//
//  UserDetailModel.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 15/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Foundation

struct UserDetailModel: Codable {
    var avatar_url : URL?
    var login: String?
    var name: String?
    var location: String?
    var company: String?
    var followers: Int?
    var following: Int?
}
