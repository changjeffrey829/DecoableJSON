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
        let stubLoginName = MockSessionObject.mockUser.login
        let stubName = MockSessionObject.mockUser.name
        var mockSession = MockSessionObject()
        let data = try? JSONEncoder().encode(MockSessionObject.mockUser)
        mockSession.data = data
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: stubLoginName) { (err) in
            if err != nil {
                XCTFail()
            } else {
                XCTAssertEqual(stubName, sut.userName(), "mismatched username")
            }
        }
    }
    
    func testViewModelShowUserProfileImageURL() {
        let stubLoginName = MockSessionObject.mockUser.login
        let stubProfileImageURL = MockSessionObject.mockUser.avatarUrl
        var mockSession = MockSessionObject()
        let data = try? JSONEncoder().encode(MockSessionObject.mockUser)
        mockSession.data = data
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: stubLoginName) { (err) in
            if err != nil {
                XCTFail()
            } else {
                XCTAssertEqual(stubProfileImageURL, sut.profileImageUrl(), "mismatched Profile Image URL")
            }
        }
    }
    
    func testViewModelGetUserError() {
        let stubLoginName = MockSessionObject.mockUser.login
        let mockSession = MockSessionObject()
        let mockNetwork = NetworkService(session: mockSession)
        let sut = UserViewModel(networkService: mockNetwork)
        sut.getGitHubUser(loginName: stubLoginName) { (err) in
            if let err = err {
                XCTAssertEqual(err.localizedDescription, SearchError.unableToFindUser.localizedDescription)
            } else {
                XCTFail()
            }
        }
    }
}
