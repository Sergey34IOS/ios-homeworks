//
//  FeedViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let post = Post(title: "What's going on")
    let stackView = UIStackView()
    let firstButton = UIButton()
    let secondButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    
    //    private lazy var button: UIButton = {
    //        let button = UIButton()
    //        button.backgroundColor = .orange
    //        button.layer.cornerRadius = 10
    //        button.setTitle("Show post", for: .normal)
    //        button.setTitleColor(.black, for: .normal)
    //        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
    //        return button
    //    }()
    //
    
        @objc
        private func someAction() {
            let vc = PostViewController(text: post.title)
            navigationController?.pushViewController(vc, animated: true)
        }
    
}
            
//        view.addSubview(button)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.widthAnchor.constraint(equalToConstant: 200),
//            button.heightAnchor.constraint(equalToConstant: 50)
//        ])

extension FeedViewController {
    
    private func setup() {
        view.backgroundColor = .blue
        setupNavigationVc()
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 50)]
        )
        
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        firstButton.setTitle("Кнопка раз", for: .normal)
        firstButton.backgroundColor = .orange
        
        secondButton.setTitle("Кнопка два", for: .normal)
        secondButton.backgroundColor = .systemMint
        [firstButton, secondButton].forEach {$0.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        }
        
    }
}
