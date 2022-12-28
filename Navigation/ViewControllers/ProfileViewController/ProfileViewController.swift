//
//  ProfileViewController.swift
//  Navigation
//
// Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    private let footerButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func someAction() {
        print("Вкл.")
    }
}

extension ProfileViewController {
    
    private func setup() {
        setupNavigationVc()
        self.view.addSubview(profileHeaderView)
        self.view.addSubview(footerButton)
        footerButton.backgroundColor = .purple
        footerButton.setTitle("Кнопка", for: .normal)
        footerButton.setTitleColor(.systemYellow, for: .normal)
        footerButton.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        
        [profileHeaderView, footerButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate( [
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            footerButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            footerButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            footerButton.heightAnchor.constraint(equalToConstant: 50),
            footerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
    
    private func setupNavigationVc() {
        title = "Профиль"
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


            

            
