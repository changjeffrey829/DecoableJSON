//
//  ViewController.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/27/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    private func loadData() {
        NetworkManager.share.fetchData(username: "changjeffrey829")
    }

}

