//
//  NetworkService.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 4/4/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class NetworkService {
    private var session: DataSessionProtocol
    let gitHubAPI = "https://api.github.com/users/"
    
    init(session: DataSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, SearchError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(SearchError.unableToFindUser))
            return}
        
        session.loadData(from: url) { (data, response, err) in
            if err != nil {
                completion(.failure(SearchError.unableToFindUser))
                return
            }
            
            guard
                let imageData = data,
                let photoImage = UIImage(data: imageData)
                else {
                    completion(.failure(SearchError.unableToFindUser))
                    return }
            completion(.success(photoImage))
        }
    }
    
    func getGitHubUser(loginName: String, completion: @escaping (Result<GitHubUser, SearchError>) -> ()) {
        let userText = loginName.lowercased().removeWhitespace()
        guard let gitUrl = URL(string: gitHubAPI + userText) else {
            let err = SearchError.unableToFindUser
            completion(.failure(err))
            return }
        session.loadData(from: gitUrl) { (data, response, error) in
            if error != nil {
                let err = SearchError.unableToFindUser
                completion(.failure(err))
                return
            }
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
