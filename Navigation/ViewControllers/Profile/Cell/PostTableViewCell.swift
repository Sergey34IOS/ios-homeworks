//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by My Air on 02.02.2023.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    var views: Int = 0 {
        didSet {
            cellViews.text = "Views: \(views)"
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
    
    private lazy var cellLikes: UILabel = {
        let cellLikes = UILabel()
        cellLikes.font = .systemFont(ofSize: 16)
        cellLikes.textColor = .black
        cellLikes.isUserInteractionEnabled = true
        return cellLikes
    }()
    
    private lazy var cellViews: UILabel = {
        let cellViews = UILabel()
        cellViews.font = .systemFont(ofSize: 16)
        cellViews.textColor = .black
        return cellViews
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeViews(view: Int) {
        self.cellViews.text = "Views: \(view)"
    }
    
    private func addSubviews() {
        contentView.addSubview(cellAuthor)
        contentView.addSubview(cellImage)
        contentView.addSubview(cellDescription)
        contentView.addSubview(cellLikes)
        contentView.addSubview(cellViews)
    }
    
    private func setConstraints() {
        [cellAuthor, cellImage, cellDescription, cellLikes, cellViews].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
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
            
            cellLikes.topAnchor.constraint(equalTo: cellDescription.bottomAnchor, constant: Padding.inset),
            cellLikes.leftAnchor.constraint(equalTo: cellAuthor.leftAnchor),
            
            cellViews.topAnchor.constraint(equalTo: cellLikes.topAnchor),
            cellViews.rightAnchor.constraint(equalTo: cellAuthor.rightAnchor),
            cellViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,  constant: -Padding.inset)])
    }
    
    func configPost(post: Post) {
        
        cellAuthor.text = post.author
        cellImage.image = UIImage(named: post.image)
        cellDescription.text = post.description
        cellLikes.text = "Likes: \(post.likes)"
        cellViews.text = "Views: \(post.views)"
    }
}
