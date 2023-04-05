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
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
        
            arrowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            arrowButton.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
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
        MockModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        cell.configure(image:  MockModel.photos[indexPath.item] ?? UIImage())
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewController = SelectedPhotoViewController(image: MockModel.photos[indexPath.row + 1] ?? UIImage())
        viewController.name = String(indexPath.row + 1)
        
        if let tableView = superview as? UITableView {
            if let vc = tableView.dataSource as? UIViewController {
                vc.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}
