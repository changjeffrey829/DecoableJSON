//
//  NetworkServiceTests.swift
//  DecoableJSONTests
//
//  Created by Jeffrey Chang on 4/4/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import DecoableJSON

class NetworkServiceTests: XCTestCase {
    
    func testFindUser() {
        let mockSession = MockSession()
        let sut = NetworkService(session: mockSession)
        sut.getGitHubUser(loginName: "changjeffrey829") { (result) in
            switch result {
            case .failure( _):
                XCTFail()
            case .success(let user):
                XCTAssertEqual(user.name, "Jeffrey Chang")
            }
        }
    }
    
    func testCanNotFindUser() {
        let mockSession = MockSession()
        let sut = NetworkService(session: mockSession)
        sut.getGitHubUser(loginName: "anyDummyName") { (result) in
            switch result {
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, SearchError.unableToFindUser.localizedDescription)
            case .success(_):
                XCTFail()
            }
        }
    }
}
