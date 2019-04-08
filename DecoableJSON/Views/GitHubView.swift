//
//  GitHubView.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 4/6/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class GitHubView: UIView {
    
    var stackViewHeightAnchor: NSLayoutDimension?
    var stackViewWidthAnchor: NSLayoutDimension?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [profileImageView, userNameLabel, searchTextField, searchButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackViewHeightAnchor = stackView.heightAnchor
        stackViewWidthAnchor = stackView.widthAnchor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackViewHeightAnchor?.constraint(equalToConstant: frame.height / 2).isActive = true
        stackViewWidthAnchor?.constraint(equalTo: widthAnchor, multiplier: 0.70).isActive = true
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "add_photo"))
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
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
