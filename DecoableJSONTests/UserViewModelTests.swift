//
//  DecoableJSONTests.swift
//  DecoableJSONTests
//
//  Created by Jeffrey Chang on 3/22/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import DecoableJSON

class UserViewModelTests: XCTestCase {
    
    var sut: UserViewModel!

    override func setUp() {
        sut = UserViewModel()
    }
    
    func testAddUser() {
        
        let stubLoginName = "changjeffrey829"
//        let stubName = "Jeffrey Chang"
//        let stubAvatarURL = "https://avatars0.githubusercontent.com/u/22721574?v=4"
        let expectation = self.expectation(description: "addUserTest")
        struct MockDataObject: DataObjectProtocol {
            var response: URLResponse?
            var error: Error?
            func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
                let data = try? JSONEncoder().encode(UserViewModelTests.mockUser)
//                let data = try? JSONSerialization.data(withJSONObject: mockJSONString)
//                print("something something \(data)")
//                let encoder = JSONEncoder(GitHub)
//                mockJSONString.data(using: .utf8)
                completionHandler(data, response, error)
//                return MockURLSessionDataTask()
                return URLSessionDataTask()
            }
        }
        
        class MockURLSessionDataTask: URLSessionDataTaskProtocol {
            private (set) var resumeWasCalled = false
            func resume() {
                resumeWasCalled = true
            }
        }
//        let sut = UserViewModel(session: MockDataObject())
        sut.setGitHubUser(loginName: stubLoginName) { [unowned self] (err) in
            if err != nil {
                self.tearDown()
                XCTFail()
            }
//            XCTAssertEqual(stubName, self.sut.userName(), "mismatched username")
//            XCTAssertEqual(stubAvatarURL, self.sut.profileImageUrl())
            self.tearDown()
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                self.tearDown()
                XCTFail()
            }
        }
    }
    
    func testThrowErrorWithBadInput() {
        let stubLoginName = "changjeffrey8291"
        let expectation = self.expectation(description: "badInputTest")
        expectation.isInverted = true
        sut.setGitHubUser(loginName: stubLoginName) { [unowned self] (err) in
            self.tearDown()
            if err != nil {
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                self.tearDown()
                XCTFail()
            }
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    static let mockUser = GitHubUser(login: "changjeffrey829", id: 22721574, nodeId: "MDQ6VXNlcjIyNzIxNTc0", avatarUrl: "https://avatars0.githubusercontent.com/u/22721574?v=4", gravatarId: "", url: "https://api.github.com/users/changjeffrey829", htmlUrl: "https://github.com/changjeffrey829", followersUrl: "https://api.github.com/users/changjeffrey829/followers", followingUrl: "https://api.github.com/users/changjeffrey829/following{/other_user}", gistsUrl: "https://api.github.com/users/changjeffrey829/gists{/gist_id}", starredUrl: "https://api.github.com/users/changjeffrey829/starred{/owner}{/repo}", subscriptionsUrl: "https://api.github.com/users/changjeffrey829/subscriptions", organizationsUrl: "https://api.github.com/users/changjeffrey829/orgs", reposUrl: "https://api.github.com/users/changjeffrey829/repos", eventsUrl: "https://api.github.com/users/changjeffrey829/events{/privacy}", receivedEventsUrl: "https://api.github.com/users/changjeffrey829/received_events", type: "User", siteAdmin: false, name: "Jeffrey Chang", company: nil, blog: "", location: nil, email: nil, hirable: nil, bio: "Self-taught iOS dev.", publicRepos: 7, publicGists: 0, followers: 0, following: 4, createdAt: "2016-10-09T05:05:56Z", updatedAt: "2019-01-03T19:39:57Z")
    
    static let mockJSONString = """
    {
        "login": "changjeffrey829",
        "id": 22721574,
        "node_id": "MDQ6VXNlcjIyNzIxNTc0",
        "avatar_url": "https://avatars0.githubusercontent.com/u/22721574?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/changjeffrey829",
        "html_url": "https://github.com/changjeffrey829",
        "followers_url": "https://api.github.com/users/changjeffrey829/followers",
        "following_url": "https://api.github.com/users/changjeffrey829/following{/other_user}",
        "gists_url": "https://api.github.com/users/changjeffrey829/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/changjeffrey829/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/changjeffrey829/subscriptions",
        "organizations_url": "https://api.github.com/users/changjeffrey829/orgs",
        "repos_url": "https://api.github.com/users/changjeffrey829/repos",
        "events_url": "https://api.github.com/users/changjeffrey829/events{/privacy}",
        "received_events_url": "https://api.github.com/users/changjeffrey829/received_events",
        "type": "User",
        "site_admin": false,
        "name": "Jeffrey Chang",
        "company": nil,
        "blog": "",
        "location": nil,
        "email": nil,
        "hireable": nil,
        "bio": "Self-taught iOS dev.",
        "public_repos": 7,
        "public_gists": 0,
        "followers": 0,
        "following": 4,
        "created_at": "2016-10-09T05:05:56Z",
        "updated_at": "2019-01-03T19:39:57Z"
    }
"""
}
