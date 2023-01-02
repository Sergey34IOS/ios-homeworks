//
//  TextFieldsVC.swift
//  Navigation
//
//  Created by My Air on 02.01.2023.
//

import UIKit

final class TextFieldsView: UIView {
    
    private let separatorView = UIView()
    private let emailPhoneTextField = LogInTextField(placeholderText: "Phone or email")
    private let passwordTextField = LogInTextField(placeholderText: "Password", state: .secure)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldsView {
    
    private func setup() {
        addSubview(separatorView)
        addSubview(emailPhoneTextField)
        addSubview(passwordTextField)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        emailPhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        separatorView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            emailPhoneTextField.widthAnchor.constraint(equalTo: widthAnchor),
            emailPhoneTextField.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            passwordTextField.widthAnchor.constraint(equalTo: widthAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
