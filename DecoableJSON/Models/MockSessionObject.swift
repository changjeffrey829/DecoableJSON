//
//  MockSessionObject.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 3/27/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

struct MockSessionObject: DataSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
    
    static let mockUser = GitHubUser(login: "changjeffrey829", id: 22721574, nodeId: "MDQ6VXNlcjIyNzIxNTc0", avatarUrl: "https://avatars0.githubusercontent.com/u/22721574?v=4", gravatarId: "", url: "https://api.github.com/users/changjeffrey829", htmlUrl: "https://github.com/changjeffrey829", followersUrl: "https://api.github.com/users/changjeffrey829/followers", followingUrl: "https://api.github.com/users/changjeffrey829/following{/other_user}", gistsUrl: "https://api.github.com/users/changjeffrey829/gists{/gist_id}", starredUrl: "https://api.github.com/users/changjeffrey829/starred{/owner}{/repo}", subscriptionsUrl: "https://api.github.com/users/changjeffrey829/subscriptions", organizationsUrl: "https://api.github.com/users/changjeffrey829/orgs", reposUrl: "https://api.github.com/users/changjeffrey829/repos", eventsUrl: "https://api.github.com/users/changjeffrey829/events{/privacy}", receivedEventsUrl: "https://api.github.com/users/changjeffrey829/received_events", type: "User", siteAdmin: false, name: "Jeffrey Chang", company: nil, blog: "", location: nil, email: nil, hirable: nil, bio: "Self-taught iOS dev.", publicRepos: 7, publicGists: 0, followers: 0, following: 4, createdAt: "2016-10-09T05:05:56Z", updatedAt: "2019-01-03T19:39:57Z")
}
