//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
       
    lazy var image: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuation
    
    func configure(image: UIImage) {
        self.image.image = image
    }
    
    // MARK: - Action
//    @objc
//    private func showPhoto() {
//        UIImageView.animate(withDuration: 0.5,
//                            delay: 0.1
//        ) { [self] in
//            transparentView.alpha = 0.5
//            image.layer.borderWidth = 0
//            image.layer.cornerRadius = 0
//            image.center = transparentView.center
//            image.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
////            tabBar?.frame.origin.y = UIScreen.main.bounds.height
//        }
//    completion: { _ in
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            self?.xButton.alpha = 1
//        }
//    }
//    }
    
    
    @objc
    private func closePhotoAction() {
        
    }
}

extension PhotoCollectionViewCell {
    private func setSubviews() {
        addSubview(image)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor),
            image.rightAnchor.constraint(equalTo: rightAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
