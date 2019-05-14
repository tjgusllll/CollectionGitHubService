//
//  ServiceError.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case unkown
    case requestFailed(Error)
    case decodeError
}
