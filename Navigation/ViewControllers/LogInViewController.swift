//
//  LogInViewController.swift
//  Navigation
//
//  Created by My Air on 27.12.2022.
//

import UIKit

final class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private let logoImage: UIImageView = {
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        return logoImage
    }()
    
    private lazy var loginForm: UIStackView = {
        let loginForm = UIStackView()
        loginForm.backgroundColor = .systemGray6
        loginForm.axis = .vertical
        loginForm.distribution = .fillEqually
        loginForm.alignment = .fill
        loginForm.layer.cornerRadius = 10
        loginForm.layer.borderColor = UIColor.lightGray.cgColor
        loginForm.layer.borderWidth = 0.5
        loginForm.clipsToBounds = true
        return loginForm
    }()
    
    private lazy var emailField: UITextField = {
        let loginText = UITextField()
        loginText.backgroundColor = .systemGray6
        loginText.placeholder = "Email"
        loginText.layer.borderColor = UIColor.lightGray.cgColor
        loginText.layer.borderWidth = 0.5
        loginText.autocapitalizationType = .none
        loginText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Padding.inset, height: 0))
        loginText.delegate = self
        loginText.leftViewMode = .always
        loginText.rightViewMode = .always
        loginText.translatesAutoresizingMaskIntoConstraints = false
        return loginText
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.placeholder = "Password"
        passwordText.backgroundColor = .systemGray6
        passwordText.textColor = .black
        passwordText.font = .systemFont(ofSize: 16)
        passwordText.tintColor = UIColor(named: "customBlue")
        passwordText.isSecureTextEntry = true
        passwordText.autocapitalizationType = .none
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Padding.inset, height: 0))
        passwordText.delegate = self
        passwordText.leftViewMode = .always
        passwordText.rightViewMode = .always
        passwordText.rightView = .some(errorPasswordLabel)
        return passwordText
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.init(named: "customBlue")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.alpha = (button.isSelected || button.isHighlighted) ? 0.7 : 1
        button.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorPasswordLabel: UILabel = {
        let error = UILabel()
        error.isHidden = true
        error.textColor = .systemRed
        error.text = "Min. 4 symbols "
        return error
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        setupGesture()
        setupNotifications()
    }
    
    
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(contentView)
        contentView.addSubview(logoImage)
        contentView.addSubview(loginForm)
        view.addSubview(logInButton)
        loginForm.addArrangedSubview(emailField)
        loginForm.addArrangedSubview(passwordTextField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Action
    
    @objc
    private func logInAction() {
        if emailField.text == "" || passwordTextField.text == ""
        { shakeAnimation()
        }
        else if emailField.text != "1234@mail.ru" {
            makeEmailAlert()
        }
        else if passwordTextField.text!.count < 4 {
            errorPasswordLabel.text = errorPasswordLabel.text
            errorPasswordLabel.isHidden = false
        }
        else if passwordTextField.text! != "1234" {
            makePassAlert()
        }
        else {
            let vc = ProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: loginForm.center.x - 10, y: loginForm.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: loginForm.center.x + 10, y: loginForm.center.y))
        
        loginForm.layer.add(animation, forKey: "position")
    }
    
    private func  minimumPassLengthAlert() {
        
        
    }
    private func makeEmailAlert() {
        let alertController = UIAlertController(title: "Wrong email", message: "Enter 1234@mail.ru", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Back", style: .default, handler: { _ in
            self.dismiss(animated: true)
        })
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func makePassAlert() {
        let alertController = UIAlertController(title: "Wrong password", message: "Enter 1234", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Back", style: .default, handler: { _ in
            self.dismiss(animated: true)
        })
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(dismissKeyboarFrame))
    }
    
    @objc
    private func tap() {
        view.endEditing(true)
        view.layoutIfNeeded()
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc
    private func dismissKeyboarFrame() {
        view.endEditing(true)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setConstraints() {
        
        [scrollView, contentView, loginForm, logInButton, logoImage, emailField, passwordTextField].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Padding.inset),
                scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Padding.inset),
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                
                
                logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
                logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImage.heightAnchor.constraint(equalToConstant: Padding.heightAnchor),
                logoImage.widthAnchor.constraint(equalToConstant: Padding.heightAnchor),
                
                loginForm.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
                loginForm.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: Padding.inset),
                loginForm.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -Padding.inset),
                loginForm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                
                emailField.topAnchor.constraint(equalTo: loginForm.topAnchor),
                emailField.leftAnchor.constraint(equalTo: loginForm.leftAnchor),
                emailField.rightAnchor.constraint(equalTo: loginForm.rightAnchor),
                emailField.heightAnchor.constraint(equalToConstant: 50),
                
                passwordTextField.topAnchor.constraint(equalTo: emailField.bottomAnchor),
                passwordTextField.leftAnchor.constraint(equalTo: loginForm.leftAnchor),
                passwordTextField.rightAnchor.constraint(equalTo: loginForm.rightAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                
                logInButton.topAnchor.constraint(equalTo: loginForm.bottomAnchor, constant: Padding.inset),
                logInButton.leftAnchor.constraint(equalTo: loginForm.leftAnchor),
                logInButton.rightAnchor.constraint(equalTo: loginForm.rightAnchor),
                logInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
}
