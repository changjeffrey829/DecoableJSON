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
    
    func fetchData(username: String) {
        let userText = username.lowercased()
        
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText) else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                print("this is pre decode data \(data)")
                let user = try decoder.decode(GitHubUser.self, from: data)
                
                
                print("this is pre decode data \(user)")
                DispatchQueue.main.sync {
//                    if let gimage = gitData.avatarUrl {
//                        let data = try? Data(contentsOf: gimage)
//                        let image: UIImage = UIImage(data: data!)!
//                        self.gravatarImage.image = image
//                    }
//
//
//                    if let gname = gitData.name {
//                        self.name.text = gname
//                    }
//                    if let glocation = gitData.location {
//                        self.location.text = glocation
//                    }
//
//                    if let gfollowers = gitData.followers {
//                        self.followers.text = String(gfollowers)
//                    }
//
//                    if let grepos = gitData.repos {
//                        self.blog.text = String(grepos)
//                    }
//                    self.setLabelStatus(value: false)
                }
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
