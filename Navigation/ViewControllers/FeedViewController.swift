//
//  FeedViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let post = Post(author: "", image: "", description: "What's going on", views: 0)
    let stackView = UIStackView()
    let firstButton = UIButton()
    let secondButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func someAction() {
        let vc = PostViewController(text: post.description)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FeedViewController {
    
    private func setup() {
        view.backgroundColor = .blue
        setupNavigationVc()
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: Metric.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)]
        )
        
        firstButton.setTitle("Кнопка раз", for: .normal)
        firstButton.backgroundColor = .orange
        
        secondButton.setTitle("Кнопка два", for: .normal)
        secondButton.backgroundColor = .systemMint
        [firstButton, secondButton].forEach {$0.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        }
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
