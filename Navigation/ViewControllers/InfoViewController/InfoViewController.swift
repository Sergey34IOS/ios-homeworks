//
//  AlarmViewControlle.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("Show alert", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    private func someAction() {
        makeAlertVC()
    }
    
    private func makeAlertVC() {
        let alertController = UIAlertController(title: "Alert", message: "Attention", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: "Back", style: .default, handler: { _ in
            self.dismiss(animated: true)
        })
        let secondAlertAction = UIAlertAction(title: "Print message", style: .default, handler: { _ in
            print("Notice")
        })
        alertController.addAction(firstAlertAction)
        alertController.addAction(secondAlertAction)
        present(alertController, animated: true)
    }
}

extension InfoViewController {
    private func setup() {
        view.addSubview(button)
        view.backgroundColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

