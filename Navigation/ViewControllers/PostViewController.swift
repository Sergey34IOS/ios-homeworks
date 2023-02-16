//
//  PostViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        title = text
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func tapAction() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
}

extension PostViewController {
    
    private func setup() {
        setupNavigationVc()
        view.backgroundColor = .systemCyan
    }
    
    private func setupNavigationVc() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.backgroundColor = .gray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAction))
    }
}

