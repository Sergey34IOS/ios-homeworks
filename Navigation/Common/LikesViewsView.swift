//
//  LikesViewsView.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

final class LikesViewsView: UIView {
    
    // MARK: - Properties
    
    var views: Int = 0 {
        didSet {
            viewButton.setTitle("Views: \(views)", for: .normal)
        }
    }
    
    private (set) lazy var likesButton: UIButton = {
        let likesButton = UIButton()
        likesButton.setTitle("Likes: 0", for: .normal)
        likesButton.setTitleColor(.black, for: .normal)
        likesButton.translatesAutoresizingMaskIntoConstraints = false
        return likesButton
    }()
    
    private (set) lazy var viewButton: UIButton = {
        let viewButton = UIButton()
        viewButton.setTitle("Views: 0", for: .normal)
        viewButton.setTitleColor(.black, for: .normal)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        return viewButton
    }()
    
    init(likes: Int=0, views: Int=0) {
        super.init(frame: .zero)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LikesViewsView {
    
    // MARK: - Instance methods

    private func setViews() {
        addSubviews([likesButton, viewButton])
       
        NSLayoutConstraint.activate([
            likesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            likesButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            viewButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
