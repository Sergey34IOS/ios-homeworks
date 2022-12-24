//
//  FeedViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let post = Post(title: "What's going on")
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("Show post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func someAction() {
        let vc = PostViewController(text: post.title)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FeedViewController {
    
    private func setup() {
        view.backgroundColor = .blue
        setupNavigationVc()
        
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigationVc() {
        title = "Лента"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

