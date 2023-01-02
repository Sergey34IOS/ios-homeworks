//
//  File.swift
//  Navigation
//
//  Created by My Air on 02.01.2023.
//

import UIKit

enum StateSecure {
    case notSecure
    case secure
    
    var isSecure: Bool {
        switch self {
        case .notSecure:
            return false
        case .secure:
            return true
        }
    }
}

final class LogInTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    init(placeholderText: String, state: StateSecure = .notSecure) {
        super.init(frame: .zero)
        setup()
        placeholder = placeholderText
        isSecureTextEntry = state.isSecure
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Padding methods
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension LogInTextField {
    
    private func setup() {
        backgroundColor = .clear
    }
}

