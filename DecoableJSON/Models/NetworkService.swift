//
//  NetworkService.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 4/4/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

struct NetworkService {
    private var session: DataSessionProtocol
    init(session: DataSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func getGitHubUser(loginName: String, completion: @escaping (Result<GitHubUser, Error>) -> ()) {
        let userText = loginName.lowercased().removeWhitespace()
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText) else {
            let err = SearchError.unableToFindUser
            completion(.failure(err))
            return }
        session.loadData(from: gitUrl) { (data, response, error) in
            guard let data = data else {
                let err = SearchError.unableToFindUser
                completion(.failure(err))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(GitHubUser.self, from: data)
                completion(.success(user))
            } catch {
                let err = SearchError.unableToFindUser
                completion(.failure(err))
            }
        }
    }
}
