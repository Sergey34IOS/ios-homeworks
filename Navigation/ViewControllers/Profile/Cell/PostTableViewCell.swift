//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by My Air on 02.02.2023.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    // MARK: - Closure
    
    var addLikesHandler: ((IndexPath) -> Void)?
    
    // MARK: - Properties
    
    var indexPath: IndexPath?
    
    var likes: Int = 0 {
        didSet {
            likesLabel.text = "Likes: \(likes)"
        }
    }

    var views: Int = 0 {
        didSet {
            viewLabel.text = "Views: \(views)"
        }
    }
    
    private lazy var cellAuthor: UILabel = {
        let cellAuthor = UILabel()
        cellAuthor.font = .boldSystemFont(ofSize: 20)
        cellAuthor.textColor = .black
        cellAuthor.numberOfLines = 2
        return cellAuthor
    }()
    
    private lazy var cellDescription: UILabel = {
        let cellDescription = UILabel()
        cellDescription.font = .systemFont(ofSize: 16)
        cellDescription.textColor = .black
        cellDescription.numberOfLines = 0
        return cellDescription
    }()
    
    private lazy var cellImage: UIImageView = {
        let cellImage = UIImageView()
        cellImage.backgroundColor = .black
        cellImage.contentMode = .scaleAspectFit
        return cellImage
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = .systemFont(ofSize: 16)
        likesLabel.textColor = .black
        likesLabel.text = "Likes: 0"
        likesLabel.isUserInteractionEnabled = true
        likesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addLikes)))
        return likesLabel
    }()
    
    private lazy var viewLabel: UILabel = {
        let viewLabel = UILabel()
        viewLabel.font = .systemFont(ofSize: 16)
        viewLabel.textColor = .black
        return viewLabel
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configPost(post: Post, indexPath: IndexPath) {
        cellAuthor.text = post.author
        cellImage.image = UIImage(named: post.image)
        cellDescription.text = post.description
        viewLabel.text = "Views: \(post.views)"
        self.indexPath = indexPath
    }
    
    // MARK: - Action
    
    @objc
    private func addLikes() {
        addLikesHandler?(indexPath ?? [0, 0])
    }
    
    // MARK: - Instance methods
    
    func makeViews(view: Int) {
        self.viewLabel.text = "Views: \(view)"
    }
    
    private func addSubviews() {
        contentView.addSubview(cellAuthor)
        contentView.addSubview(cellImage)
        contentView.addSubview(cellDescription)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewLabel)
    }
    
    private func setConstraints() {
        [cellAuthor, cellImage, cellDescription, likesLabel, viewLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            cellAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.inset),
            cellAuthor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Padding.inset),
            cellAuthor.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Padding.inset),
            
            cellImage.topAnchor.constraint(equalTo: cellAuthor.bottomAnchor, constant: Padding.inset),
            cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cellImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cellImage.heightAnchor.constraint(equalTo: cellImage.widthAnchor),
            
            cellDescription.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: Padding.inset),
            cellDescription.leftAnchor.constraint(equalTo: cellAuthor.leftAnchor),
            cellDescription.rightAnchor.constraint(equalTo: cellAuthor.rightAnchor),
            
            likesLabel.topAnchor.constraint(equalTo: cellDescription.bottomAnchor, constant: Padding.inset),
            likesLabel.leftAnchor.constraint(equalTo: cellAuthor.leftAnchor),
            
            viewLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewLabel.rightAnchor.constraint(equalTo: cellAuthor.rightAnchor),
            viewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,  constant: -Padding.inset)])
    }
}
