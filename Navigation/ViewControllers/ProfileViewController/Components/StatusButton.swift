//
//  StatusButton.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class StatusButton: UIButton {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusButton {
    
    // MARK: - StatusButton Methods
    
    private func setup() {
        layer.cornerRadius = 4
        backgroundColor = .blue
        setTitle("Show status", for: .normal)
        setTitleColor(.white, for: .normal)
        
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
    }
}

