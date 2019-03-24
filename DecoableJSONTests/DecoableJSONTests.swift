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
        let stubLoginName = "changjeffrey829"
        let stubName = "Jeffrey Chang"
        let stubAvatarURL = "https://avatars0.githubusercontent.com/u/22721574?v=4"
        let expectation = self.expectation(description: "addUserTest")
        sut.setGitHubUser(loginName: stubLoginName) { [unowned self] (err) in
            if err != nil {
                self.tearDown()
                XCTFail()
            }
            XCTAssertEqual(stubName, self.sut.userName(), "mismatched username")
            XCTAssertEqual(stubAvatarURL, self.sut.profileImageUrl())
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

}
