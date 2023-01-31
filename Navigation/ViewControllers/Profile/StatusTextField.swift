//
//  StatusTextField.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

class StatusTextField: UITextField {
    
    // MARK: - Properties
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Padding methods
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension StatusTextField {
    
    // MARK: - CustomTextField Methods
    
    private func setup() {
        backgroundColor = .white
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text = "Enter status..."
    }
}

// textfield.isSecure
