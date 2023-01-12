//
//  LogInViewController.swift
//  Navigation
//
//  Created by My Air on 27.12.2022.
//

import UIKit

final class LogInViewController: UIViewController {
    
    private let logoImage = UIImageView(image: UIImage(named: "logo"))
    
    private let textFieldsView = TextFieldsView()
    
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!)
        logInButton.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        return logInButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        setupNotifications()
    }
    private func setupNotifications() {        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc
    private func logInAction() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dismissKeyboarFrame() {
        view.endEditing(true)
    }
    
    func setupElements() {
        view.addSubview(logoImage)
        view.addSubview(textFieldsView)
        view.addSubview(logInButton)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        setupGesture()
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            textFieldsView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            textFieldsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textFieldsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: 16),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(dismissKeyboarFrame))
    }
}

final class TextFieldsView: UIView {
    
    private let separatorView = UIView()
    private let emailPhoneTextField = LogInTextField(placeholderText: "Phone or email")
    private let passwordTextField = LogInTextField(placeholderText: "Password", state: .secure)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTextFieldsView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldsView {
    
    func setupTextFieldsView() {
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

final class LogInTextField: UITextField {
    
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
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    init(placeholderText: String, state: StateSecure = .notSecure) {
        super.init(frame: .zero)
        setupLogInTextField()
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
    
    private func setupLogInTextField() {
        backgroundColor = .clear
    }
}

