//
//  PhotosViewController.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

//final class PhotosViewController {
//    
//    // MARK: - Properties (UI)
//    
//    private var galleryCollectionView: UICollectionView? {
//        
//        
//    }
//    
//    
//    
//    private lazy var photoGallery: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width / 4, height: 40)
//        layout.scrollDirection = .horizontal
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "photo")
//        collectionView.dataSource = self
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        galleryCollectionView = UICollectionView(frame: .zero)
//        galleryCollectionView?.delegate = self
//        galleryCollectionView?.dataSource = self
//        guard let galleryCollectionView = galleryCollectionView else {
//            return
//        }
//        view.addSubview(galleryCollectionView)
//    }
//    
//    func collectionView(_ galleryCollectionView: UICollectionView, numbersOfItemInSection section: Int) -> Int {
//        return MockModel.photos.count
//    }
//    
//    private func collectionView(_ galleryCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//    
//    
//    override func loadView() {
//        super.loadView()
//        navigationController?.navigationBar.isHidden = false
//        view.backgroundColor = .red
//    }
//}
//
//extension PhotosViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = photoGallery.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MockModel.photos.count
//    }
//}
