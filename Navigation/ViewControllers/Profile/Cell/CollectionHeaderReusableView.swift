//
//  CollectionReusableView.swift
//  Navigation
//
//  Created by My Air on 12.04.2023.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {
    
    static let identifier = "CollectionHeaderReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Gallery"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
