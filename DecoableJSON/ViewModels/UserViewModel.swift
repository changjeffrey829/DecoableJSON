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
    private var session: DataSessionProtocol
    
    init(session: DataSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func profileImageUrl() -> String? {
        return user?.avatarUrl
    }
    
    func userName() -> String? {
        return user?.name
    }
    
    func setGitHubUser(loginName: String, completion: @escaping (Error?) -> ()) {
        let userText = loginName.lowercased().removeWhitespace()
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText) else {
            let err = SearchError.unableToFindUser
            completion(err)
            return }
        session.loadData(from: gitUrl) { (data, response, error) in
            guard let data = data else {
                let err = SearchError.unableToFindUser
                completion(err)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(GitHubUser.self, from: data)
                self.user = user
                completion(nil)
            } catch {
                let err = SearchError.unableToFindUser
                completion(err)
            }
        }
//        let dataTask = session.dataTask(with: gitUrl) { [unowned self] (data, response
//            , error) in
//            guard let data = data else {
//                let err = SearchError.unableToFindUser
//                completion(err)
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let user = try decoder.decode(GitHubUser.self, from: data)
//                self.user = user
//                completion(nil)
//            } catch {
//                let err = SearchError.unableToFindUser
//                completion(err)
//            }
//        }
//        dataTask.resume()
    }
}
