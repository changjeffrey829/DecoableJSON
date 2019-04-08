//
//  ViewController.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/27/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

class GitHubViewController: UIViewController {
    
    var userViewModel = UserViewModel()
    var gitHubView = GitHubView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func searchUser() {
        guard let text = gitHubView.searchTextField.text else {return}
        userViewModel.getGitHubUser(loginName: text) { [unowned self] (err) in
            if let err = err {
                DispatchQueue.main.async {
                    let alert = self.badUserSearchAlert(searchError: err)
                    self.present(alert, animated: true)
                }
            }
            self.loadUserToView()
        }
    }
    
    private func setupView() {
        view = gitHubView
        gitHubView.searchButton.addTarget(self, action: #selector(searchUser), for: .touchUpInside)
    }
    
    private func badUserSearchAlert(searchError: SearchError) -> UIAlertController {
        let title: String
        switch searchError {
        case .unableToFindImage:
            title = "Image can not be found"
        case .unableToFindUser:
            title = "User can not be found"
        }
        let alert = UIAlertController(title: title, message: "please try again", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "dismiss", style: .default, handler: nil)
        alert.addAction(dismissAction)
        return alert
    }

    private func loadUserToView() {
        guard let profileUrl = self.userViewModel.profileImageUrl() else {return}
        self.userViewModel.getImagefromURL(urlString: profileUrl, completion: { (result) in
            DispatchQueue.main.async {
                self.gitHubView.searchTextField.text = ""
                switch result {
                case .success(let image):
                    let name = self.userViewModel.userName()
                    self.gitHubView.profileImageView.image = image
                    self.gitHubView.userNameLabel.text = name
                case .failure(let err):
                    let alert = self.badUserSearchAlert(searchError: err)
                    self.present(alert, animated: true)
                }
            }
        })
    }
}

