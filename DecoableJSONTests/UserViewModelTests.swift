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
    
    func testAddUser() {
        let stubLoginName = "changjeffrey829"
        let stubName = "Jeffrey Chang"
        let stubAvatarURL = "https://avatars0.githubusercontent.com/u/22721574?v=4"
        var mockSession = MockSessionObject()
        let data = try? JSONEncoder().encode(MockSessionObject.mockUser)
        mockSession.data = data
        let sut = UserViewModel(session: mockSession)
        sut.setGitHubUser(loginName: stubLoginName) { (err) in
            XCTAssertNil(err)
            XCTAssertEqual(stubName, sut.userName(), "mismatched username")
            XCTAssertEqual(stubAvatarURL, sut.profileImageUrl())
        }
    }
    
    func testThrowErrorWithBadInput() {
        var mockSession = MockSessionObject()
        mockSession.error = SearchError.unableToFindUser
        let sut = UserViewModel(session: mockSession)
        let stubLoginName = "changjeffrey8291"
        sut.setGitHubUser(loginName: stubLoginName) { (err) in
            XCTAssertNil(sut.userName())
            XCTAssertNil(sut.profileImageUrl())
            if err == nil {
                XCTFail()
            }
        }
    }
}
