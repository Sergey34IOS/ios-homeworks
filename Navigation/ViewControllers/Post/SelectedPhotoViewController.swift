//
//  Photo.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

class SelectedPhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initializers
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setViews()
        self.image.image = image
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationItem.backButtonTitle = ""
    }
}

extension SelectedPhotoViewController {
    
    // MARK: - Instance methods
    
    private func setViews() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            image.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

