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
}
