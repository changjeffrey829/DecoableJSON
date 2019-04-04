//
//  ViewModel.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

enum SearchError: Error {
    case unableToFindUser
}

class UserViewModel {
    private var user: GitHubUser?
    private var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func profileImageUrl() -> String? {
        return user?.avatarUrl
    }
    
    func userName() -> String? {
        return user?.name
        
    }
    
    func getGitHubUser(loginName: String, completion: @escaping (Error?) -> ()) {
        networkService.getGitHubUser(loginName: loginName) { (result) in
            switch result {
            case .failure(let err):
                completion(err)
            case .success(let user):
                self.user = user
                completion(nil)
            }
        }
    }
}
