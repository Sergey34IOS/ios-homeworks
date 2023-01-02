//
//  LogInViewController.swift
//  Navigation
//
//  Created by My Air on 27.12.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let logoImage: UIImageView = {
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        return logoImage
    }()
    private let textFieldsView = TextFieldsView()
    private (set) lazy var logInButton: UIButton = {
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
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
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
        present(vc, animated: true)
    }
    
    @objc private func dismissKeyboarFrame() {
        view.endEditing(true)
    }
    
    func setup() {
        setupGesture()
        view.addSubview(logoImage)
        view.addSubview(textFieldsView)
        view.addSubview(logInButton)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
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
