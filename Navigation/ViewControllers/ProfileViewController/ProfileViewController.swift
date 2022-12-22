//
//  ProfileViewController.swift
//  Navigation
//
// Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ProfileViewController {
    
    private func setup() {
        setupNavigationVc()
        self.view = profileHeaderView
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
