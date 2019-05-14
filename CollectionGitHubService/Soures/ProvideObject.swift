//
//  ProvideObject.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 13/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import UIKit

enum ProvideObject {
    case allUser
    case detailUser(name: String)
}

extension ProvideObject {
    var viewController: UIViewController {
        switch self {
        case .allUser:
            let viewController = AllUserViewController()
            return viewController
        case .detailUser(let name):
            let viewController = UserDetailViewController(userName:name) 
            return viewController
        }
    }
}

