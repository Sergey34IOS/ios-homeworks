//
//  DetailPostViewController.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

final class DetailPostViewController: UIViewController {
    
    // MARK: - Closure
    
    var viewsHandler: (() -> Void)?
    
    // MARK: - Properties
    
    private lazy var postImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var likesLabel: UILabel = {
        let likes = UILabel()
        likes.textColor = .black
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.numberOfLines = 0
        likes.clipsToBounds = true
        likes.layer.masksToBounds = true
        return likes
    }()
    
    private lazy var viewsLabel: UILabel = {
        let views = UILabel()
        views.clipsToBounds = true
        views.layer.masksToBounds = true
        views.textColor = .black
        views.font = UIFont.systemFont(ofSize: 16)
        views.numberOfLines = 0
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    // MARK: - Lifecycle
    
    init(model: Post, likes: Int, viewsHandler: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        setModel(model: model, likes: likes)
        self.viewsHandler = viewsHandler
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
    }
    
    deinit {
        viewsHandler?()
    }
}

extension DetailPostViewController {
    
    // MARK: - Instance methods
    
    private func setModel(model: Post, likes: Int) {
        self.title = model.author
        self.postImageView.image = UIImage(named: model.image)
        self.descriptionLabel.text = model.description
        self.likesLabel.text = "Likes: \(likes)"
        self.viewsLabel.text = "Views: \(model.views)"
    }
    
    private func setViews() {
        view.addSubviews([postImageView, descriptionLabel, likesLabel, viewsLabel])
        
        [postImageView, descriptionLabel, viewsLabel, likesLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            postImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Padding.inset),
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: Padding.inset),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Padding.inset),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Padding.inset),
            likesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Padding.inset),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Padding.inset),
            viewsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Padding.inset),
        ])
    }
}
