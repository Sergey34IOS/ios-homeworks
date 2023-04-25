//
//  PhotosViewCell.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

protocol ArrowDidTapDelegate: AnyObject {
    func arrowDidTap()
}

final class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Closure
    
    var closure: ((UIImageView) -> Void)?
    
    // MARK: - Properties
    
    weak var arrowDidTapDelegate: ArrowDidTapDelegate?
    
    private  var descriptionLabel: UILabel = {
        var galleryLabel = UILabel()
        galleryLabel.text = "Photos"
        galleryLabel.font = .boldSystemFont(ofSize: 24)
        galleryLabel.textColor = .black
        galleryLabel.translatesAutoresizingMaskIntoConstraints = false
        return galleryLabel
    }()
    
    private lazy var arrowButton: UIButton = {
        var arrow = UIButton()
        arrow.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        arrow.addTarget(self, action: #selector(arrowAction), for: .touchUpInside)
        arrow.backgroundColor = .clear
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentView.frame.size.width / 3, height: 60)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(arrowButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.photosTable),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Padding.photosTable),
            
            arrowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Padding.photosTable),
            arrowButton.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.photosTable),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.photosTable),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.photosTable),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    @objc
    private func arrowAction() {
        arrowDidTapDelegate?.arrowDidTap()
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Model.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        cell.configure(image: Model.photos[indexPath.item] ?? UIImage())
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewController = SelectedPhotoViewController(image: Model.photos[indexPath.row + 1] ?? UIImage())
        viewController.name = String(indexPath.row + 1)
        
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        let image = cell.image
        closure?(image)
    }
}
