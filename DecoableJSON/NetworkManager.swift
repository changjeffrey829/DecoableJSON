//
//  NetworkManager.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/27/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let share = NetworkManager()
    
    func fetchData(username: String, completion: @escaping (GitHubUser?) -> ()) {
        let userText = username.lowercased()
        
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText) else {
            return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(GitHubUser.self, from: data)
                completion(user)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
