//
//  Photo.swift
//  Navigation
//
//  Created by My Air on 04.04.2023.
//

import UIKit

class SelectedPhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var initialImageRect: CGRect = .zero
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeImage), for: .touchUpInside)
        return button
    }()
    
    private var transparentBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.frame = UIScreen.main.bounds
        return view
    }()
    
//    private lazy var tabBar = ((superview as? UITableView)?.dataSource as? UIViewController)?.tabBarController?.tabBar
    
    var name: String?
    
    private var image: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // MARK: - Initializers
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setViews()
        self.image.image = image
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationItem.backButtonTitle = ""
    }
    
    public func closeImage() {
        UIView.animate(withDuration: 0.3) { [self] in
            crossButton.removeFromSuperview()
        } completion: { _ in
            UIView.animate(withDuration: 0.3
            ) { [self] in
                transparentBlackView.alpha = 0
                image.layer.borderWidth = 3
                image.layer.cornerRadius = 65
                image.clipsToBounds = true
                //            image.center = avatarCenter
                //            image.bounds = avatarBounds
                self.setNeedsLayout()
                //                self.layoutIfNeeded()
                self.updateConstraints()
                if let bar = tabBar {
                    bar.frame.origin.y = UIScreen.main.bounds.height - bar.frame.height
                }
            }
        }
    }
}

extension SelectedPhotoViewController {
    
    // MARK: - Instance methods
    
    private func setViews() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            image.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

