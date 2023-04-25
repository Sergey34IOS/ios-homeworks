//
//  HeaderViewController.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    //    MARK: - Properties
    
    private lazy var catImage: UIImageView = {
        var catImage = UIImageView()
        catImage.image = UIImage(named: "felix")
        catImage.clipsToBounds = true
        catImage.contentMode = .scaleAspectFill
        catImage.layer.cornerRadius = 65
        catImage.layer.borderWidth = 3
        catImage.layer.borderColor = UIColor.white.cgColor
        catImage.isUserInteractionEnabled = true
        catImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageAction)))
        return catImage
    }()
    
    
    private lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()
    
    private var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.frame = UIScreen.main.bounds
        return view
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
    
    private lazy var tabBar = ((superview as? UITableView)?.dataSource as? UIViewController)?.tabBarController?.tabBar
    
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
        statusButton.backgroundColor = UIColor(named: "customBlue")
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        return statusButton
    }()
    
    private lazy var avatarCenter = catImage.center
    private lazy var avatarBounds = catImage.layer.bounds
    
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
    private func tapImageAction() {
        UIImageView.animate(withDuration: 0.5,
                            delay: 0.1
        ) { [self] in
            transparentView.alpha = 0.5
            catImage.layer.borderWidth = 0
            catImage.layer.cornerRadius = 0
            catImage.center = transparentView.center
            catImage.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            tabBar?.frame.origin.y = UIScreen.main.bounds.height
        }
    completion: { _ in
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.xButton.alpha = 1
        }
    }
    }
    @objc
    private func closeAvatar() {
        UIView.animate(withDuration: 0.3) { [self] in
            xButton.removeFromSuperview()
        } completion: { _ in
            UIView.animate(withDuration: 0.3
            ) { [self] in
                transparentView.alpha = 0
                catImage.layer.borderWidth = 3
                catImage.layer.cornerRadius = 65
                catImage.clipsToBounds = true
                catImage.center = avatarCenter
                catImage.bounds = avatarBounds
                self.setNeedsLayout()
                self.updateConstraints()
                if let bar = tabBar {
                    bar.frame.origin.y = UIScreen.main.bounds.height - bar.frame.height
                }
            }
        }
    }
    
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
            shakeTextField()
            statusLabel.text = "Print something..."
            statusTextField.placeholder = "Enter status..."
        }
    }
    
    private func shakeTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: statusTextField.center.x - 10, y: statusTextField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: statusTextField.center.x + 10, y: statusTextField.center.y))
        
        statusTextField.layer.add(animation, forKey: "position")
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
        
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
        addSubview(transparentView)
        addSubview(xButton)
        addSubview(catImage)
        
    }
    
    private func setTargets() {
        statusButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    private func addConstraints() {
        
        [xButton, catImage, nameLabel, statusButton, statusLabel, statusTextField, transparentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            catImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.inset),
            catImage.leftAnchor.constraint(equalTo: leftAnchor, constant: Padding.inset),
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
            
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Padding.inset),
            statusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: Padding.inset),
            statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Padding.inset),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            xButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.inset),
            xButton.rightAnchor.constraint(equalTo: statusButton.rightAnchor, constant: -Padding.inset),
            xButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
