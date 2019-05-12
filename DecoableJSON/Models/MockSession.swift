//
//  MockSessionObject.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 3/27/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class MockSession: DataSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if url.absoluteString == "https://api.github.com/users/changjeffrey829" {
            guard let path = Bundle.main.path(forResource: "MockJSON", ofType: "txt") else {return}
            let url = URL(fileURLWithPath: path)
            do {
                data = try Data(contentsOf: url)
            } catch let err {
                error = err
            }
        }
        
        completionHandler(data, response, error)
    }
}
