//
//  ViewController.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/27/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userViewModel: UserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func searchUser() {
        userViewModel = nil
        guard let text = searchTextField.text else {return}
        NetworkManager.share.fetchData(username: text) { [unowned self] (user) in
            guard let user = user else {return}
            self.userViewModel = UserViewModel(user: user)
            self.loadUser()
        }
    }
    
    private func loadUser() {
        DispatchQueue.main.async {
            self.searchTextField.text = ""
            let profileUrl = self.userViewModel?.profileImageUrl()
            let name = self.userViewModel?.userName()
            self.profileImageView.loadImage(urlString: profileUrl)
            self.userNameLabel.text = name
        }
    }
    
    // MARK: SETUP
    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, userNameLabel, searchTextField, searchButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70).isActive = true
    }
    
    // MARK: UI OBJECTS
    lazy var profileImageView: CustomImageView = {
        let imageView = CustomImageView(image: #imageLiteral(resourceName: "add_photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.clipsToBounds = true
        return label
    }()
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search User"
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.brown
        button.setTitle("SEARCH", for: UIControl.State())
        button.setTitleColor(UIColor.yellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(searchUser), for: .touchUpInside)
        return button
    }()
}

