//
//  ViewModel.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

class UserViewModel {
    private let user: GitHubUser
    
    init(user: GitHubUser) {
        self.user = user
    }
    func profileImageUrl() -> String {
        return user.avatarUrl
    }
    
    func userName() -> String {
        return user.name
    }
}
