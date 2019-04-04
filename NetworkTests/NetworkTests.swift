//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Jeffrey Chang on 4/4/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import DecoableJSON

class NetworkTests: XCTestCase {

    func testNetworkShowUser() {
        let login = "ChangJeffrey829"
        let networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Test network to find user")
        networkService.getGitHubUser(loginName: login) { (result) in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testNetworkShowUserError() {
        let login = "ChangJeffrey8291"
        let networkService = NetworkService()
        let expectation = XCTestExpectation(description: "Test network error")
        networkService.getGitHubUser(loginName: login) { (result) in
            switch result {
            case .failure(_):
                expectation.fulfill()
            case .success(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
