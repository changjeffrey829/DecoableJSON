//
//  DecoableJSONTests.swift
//  DecoableJSONTests
//
//  Created by Jeffrey Chang on 3/22/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import DecoableJSON

class DecoableJSONTests: XCTestCase {
    
    var sut: UserViewModel!

    override func setUp() {
        sut = UserViewModel()
    }
    
    func testAddUser() {
        
    }
    
    func testSwitchUser() {
        
    }
    
    func testUserName() {
        let user = GitHubUser(login: "loginID", id: 1, nodeId: "nodeID", avatarUrl: "avatarUrl", gravatarId: "gravatarId", url: "url", htmlUrl: "htmlUrl", followersUrl: "followersUrl", followingUrl: "followingUrl", gistsUrl: "gistsUrl", starredUrl: "starredUrl", subscriptionsUrl: "subscriptionsUrl", organizationsUrl: "organizationsUrl", reposUrl: "reposUrl", eventsUrl: "eventsUrl", receivedEventsUrl: "receivedEventsUrl", type: "type", siteAdmin: false, name: "name", company: nil, blog: nil, location: nil, email: nil, hirable: nil, bio: nil, publicRepos: 1, publicGists: 1, followers: 1, following: 1, createdAt: "1/1/2018", updatedAt: "1/1/2019")
        sut = UserViewModel()
        XCTAssertEqual(user.name, sut.userName())
        tearDown()
    }
    
    override func tearDown() {
        sut = nil
    }

}
