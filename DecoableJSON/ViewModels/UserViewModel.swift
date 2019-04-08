//
//  ViewModel.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

var imageCache = [String : UIImage]()

enum SearchError: Error {
    case unableToFindUser
    case unableToFindImage
}

class UserViewModel {
    private var user: GitHubUser?
    private var networkService: NetworkService
    private var lastUrlUsedToLoadImage: String?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func profileImageUrl() -> String? {
        return user?.avatarUrl
    }
    
    func userName() -> String? {
        return user?.name
        
    }
    
    func getImagefromURL(urlString: String, completion: @escaping (Result<UIImage, SearchError>) -> ()) {
        lastUrlUsedToLoadImage = urlString
        if let cachedimage = imageCache[urlString] {
            completion(.success(cachedimage))
            return
        }
        networkService.loadImage(urlString: urlString) { (result) in
            completion(result)
        }
    }
    
    func getGitHubUser(loginName: String, completion: @escaping (SearchError?) -> ()) {
        networkService.getGitHubUser(loginName: loginName) { (result) in
            switch result {
            case .failure(_):
                completion(SearchError.unableToFindUser)
            case .success(let user):
                self.user = user
                completion(nil)
            }
        }
    }
}
