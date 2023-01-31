//
//  HeaderViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: - Properties
    
    private var statusText = ""
    
    private let catImage = UIImageView(image: UIImage(named: "felix"))
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let statusTextField = StatusTextField()
    private let statusButton = StatusButton()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        addRecognizer()
        let currentStatus = UserDefaults.standard.string(forKey: "someValue")
        if currentStatus == "" {
            self.statusLabel.text = "Print something..."
        } else {
            self.statusLabel.text = currentStatus
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text ?? "Print something"
    }
    
    @objc
    private func buttonDidTap() {
        UserDefaults.standard.set(statusTextField.text, forKey: "someValue")
        
        statusLabel.text = self.statusText
        statusTextField.text = "Enter status..."
        
        if statusText == "" {
            statusLabel.text = "Print something..."
            statusTextField.text = "Enter status..."
        }
    }
    
    @objc
    private func endEditingView() {
        self.endEditing(true)
        if statusText == "" {
            statusLabel.text = "Print something..."
        }
        statusTextField.text = "Enter status..."
    }
    
    // MARK: - Gesture
    
    private func addRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        recognizer.numberOfTapsRequired = 1
        addGestureRecognizer(recognizer)
    }
}

extension ProfileHeaderView {
    
    // MARK: - ProfileHeaderView Methods
    
    private func setup() {
        backgroundColor = .lightGray
        
        addSubview(catImage)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
        
        catImage.clipsToBounds = true
        catImage.contentMode = .scaleAspectFill
        catImage.layer.cornerRadius = 65
        catImage.layer.borderWidth = 3
        catImage.layer.borderColor = UIColor.white.cgColor
        
        nameLabel.text = "Felix the Cat"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        
        statusButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        [catImage, nameLabel, statusLabel, statusTextField, statusButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            catImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            catImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            catImage.heightAnchor.constraint(equalToConstant: 130),
            catImage.widthAnchor.constraint(equalToConstant: 130),
            
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            nameLabel.leftAnchor.constraint(equalTo: catImage.rightAnchor, constant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            statusLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -20),
            statusTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.rightAnchor.constraint(equalTo: statusButton.rightAnchor),
            
            statusButton.topAnchor.constraint(equalTo: catImage.bottomAnchor, constant: 16),
            statusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

