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
    
    // MARK: - UI
    
    private  var image: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // MARK: - Initializers
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        updateBarAppearance()
        setBackgroundcolor()
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
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateBarAppearance() {
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    private func setBackgroundcolor() {
        view.backgroundColor = .white
    }
}

