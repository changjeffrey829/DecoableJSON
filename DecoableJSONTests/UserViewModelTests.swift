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
       
    func testViewModelShowUserName() {
        let mockSession = MockSession()
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: "changjeffrey829") { (err) in
            if err != nil {
                XCTFail()
            } else {
                XCTAssertEqual("Jeffrey Chang", sut.userName(), "mismatched username")
            }
        }
    }
    
    func testViewModelShowUserProfileImageURL() {
        let mockSession = MockSession()
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: "changjeffrey829") { (err) in
            if err != nil {
                XCTFail()
            } else {
                XCTAssertEqual("https://avatars0.githubusercontent.com/u/22721574?v=4", sut.profileImageUrl(), "mismatched Profile Image URL")
            }
        }
    }
    
    func testViewModelGetUserError() {
        let mockSession = MockSession()
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: "dummyName") { (err) in
            if let err = err {
                XCTAssertEqual(err.localizedDescription, SearchError.unableToFindUser.localizedDescription)
            } else {
                XCTFail()
            }
        }
    }
}
