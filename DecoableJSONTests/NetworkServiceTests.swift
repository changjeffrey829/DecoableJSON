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
        var mockSession = MockSessionObject()
        let mockLogin = MockSessionObject.mockUser.login
        let mockName = MockSessionObject.mockUser.name
        let data = try? JSONEncoder().encode(MockSessionObject.mockUser)
        mockSession.data = data
        let sut = NetworkService(session: mockSession)
        sut.getGitHubUser(loginName: mockLogin) { (result) in
            switch result {
            case .failure( _):
                XCTFail()
            case .success(let user):
                XCTAssertEqual(user.name, mockName)
            }
        }
    }
    
    func testCanNotFindUser() {
        let mockSession = MockSessionObject()
        let stubName = MockSessionObject.mockUser.name
        let sut = NetworkService(session: mockSession)
        sut.getGitHubUser(loginName: stubName) { (result) in
            switch result {
            case .failure(let err):
                XCTAssertEqual(err.localizedDescription, SearchError.unableToFindUser.localizedDescription)
            case .success(_):
                XCTFail()
            }
        }
    }
}
