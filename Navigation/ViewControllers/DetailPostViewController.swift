//
//  DetailPostViewController.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

final class DetailPostViewController: UIViewController {
    
    // MARK: - Properties

    private lazy var myImage: UIImageView = {
        var myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.contentMode = .scaleAspectFill
        return myImage
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let likesViewsView: LikesViewsView = {
        var likesViewsView = LikesViewsView()
        likesViewsView.translatesAutoresizingMaskIntoConstraints = false
        return likesViewsView
    }()
    
    // MARK: - Lifecycle
    
    init(model: Post, views: Int, handler: @escaping (Int) -> Void) {
        super.init(nibName: nil, bundle: nil)
        handler(1)
        setModel(model: model, views: views)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setViews()
    }
}

extension DetailPostViewController {
    
    // MARK: - Instance methods
    
    private func setModel(model: Post, views: Int) {
        self.title = model.author
        self.myImage.image = UIImage(named: model.image)
        self.descriptionLabel.text = model.description
        self.likesViewsView.views = views
    }
    
    private func setViews() {
        view.addSubviews([myImage, descriptionLabel, likesViewsView])
        
        NSLayoutConstraint.activate([
            myImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            myImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            myImage.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            likesViewsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            likesViewsView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesViewsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            likesViewsView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
