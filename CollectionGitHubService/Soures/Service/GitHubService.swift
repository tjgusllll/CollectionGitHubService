//
//  GitHubService.swift
//  CollectionGitHubService
//
//  Created by 조서현 on 14/05/2019.
//  Copyright © 2019 조서현. All rights reserved.
//

import Alamofire

class GitHubService: GitHubServiceType {
    func requestGitHubSericeAllUser(since: Int, completion: @escaping (Result<[UserModel]>) -> ()) {
        Alamofire.request(Router.userAll(since: since))
            .validate(statusCode: 200..<400)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    do {
                        let result = try JSONDecoder().decode([UserModel].self, from: value)
                        completion(Result.success(result))
                    } catch {
                        completion(Result.failure(ServiceError.decodeError))
                    }
                case .failure(let error):
                    completion(Result.failure(ServiceError.requestFailed(error)))
                }
        }
    }
    
    
}
