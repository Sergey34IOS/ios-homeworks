//
//  HeaderViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var catImage: UIImageView = {
        var catImage = UIImageView()
        catImage.image = UIImage(named: "felix")
        catImage.clipsToBounds = true
        catImage.contentMode = .scaleAspectFill
        catImage.layer.cornerRadius = 65
        catImage.layer.borderWidth = 3
        catImage.layer.borderColor = UIColor.white.cgColor
        return catImage
    }()
    
    private var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Felix the Cat"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    private var statusLabel: UILabel = {
        var statusLabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    
    private var statusText: String = ""
    
    private var statusTextField: UITextField = {
        var statusTextField = UITextField()
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.placeholder = "Enter status..."
        statusTextField.clearButtonMode = .whileEditing
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        statusTextField.leftViewMode = .always
        return statusTextField
    }()

    private var statusButton: UIButton = {
        var statusButton = UIButton()
        statusButton.layer.cornerRadius = 12
        statusButton.backgroundColor = UIColor(named: "custom_blue_color")
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        return statusButton
    }()
    
    // MARK: - Initializers
    
   override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        addSubviews()
        setTargets()
        addConstraints()
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
        statusTextField.placeholder = "Enter status..."
        
        if statusText == "" {
            statusLabel.text = "Print something..."
            statusTextField.placeholder = "Enter status..."
        }
    }
    
    @objc
    private func endEditingView() {
        self.endEditing(true)
        if statusText == "" {
            statusLabel.text = "Print something..."
        }
    }
    
    // MARK: - Gesture
    
    private func addRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        recognizer.numberOfTapsRequired = 1
        addGestureRecognizer(recognizer)
    }
}

extension ProfileHeaderView {
    
    private func addSubviews() {
        addSubview(catImage)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
    }
    
    private func setTargets() {
        statusButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    private func addConstraints() {
        
        [catImage, nameLabel, statusButton, statusLabel, statusTextField].forEach {
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
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            statusTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.rightAnchor.constraint(equalTo: statusButton.rightAnchor),
            
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            statusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
