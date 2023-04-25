//
//  ProfileViewController.swift
//  Navigation
//
// Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var image = UIImageView()
    var model = MockModel.post
    
//    // MARK: - Closure
//
//    private lazy var animateHandler: (UIImageView) -> Void = { image in
//        self.showAnimate(image: image)
//    }
    
    // MARK: - Properties
    
    let tableHeaderHeight: CGFloat = 220
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "post")
        return tableView
    }()
    
    private lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissAnimate), for: .touchUpInside)
        return button
    }()
    
    private var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        setBackgroundcolor()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Instance methods
    
    private func setViews() {
        view.addSubview(tableView)
        view.addSubview(transparentView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setBackgroundcolor() {
        view.backgroundColor = .systemBackground
    }
    
    private func showAnimate(image: UIImageView) {
        UIImageView.animate(withDuration: 0.5,
                            delay: 0.1
        ) { [self] in
            transparentView.alpha = 1
            image.layer.borderWidth = 0
            image.layer.cornerRadius = 0
            transparentView.addSubview(image)
            transparentView.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            image.center = transparentView.center
            image.alpha = 1
            tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height
            self.view.layoutIfNeeded()
            self.updateViewConstraints()
        }
    completion: { _ in
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.xButton.removeFromSuperview()
        }
    }
    }
    
    // MARK: - Action
    
    @objc
    private func dismissAnimate() {
        UIView.animate(withDuration: 0.3) { [self] in
            xButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.3
                           //                           usingSpringWithDamping: 0.5,
                           //                           initialSpringVelocity: 1,
                           //                           options: .curveEaseInOut
                           
            ) { [self] in
                transparentView.alpha = 0
                self.view.layoutIfNeeded()
                self.view.updateConstraints()
//                if let bar = tabBar {
//                    bar.frame.origin.y = UIScreen.main.bounds.height - bar.frame.height
//                }
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            cell.arrowDidTapDelegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            cell.configPost(post: model[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
           self.tableView.beginUpdates()
           self.model.remove(at: indexPath.row)
           self.tableView.deleteRows(at: [indexPath], with: .automatic)
           self.tableView.endUpdates()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? ProfileHeaderView() : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? tableHeaderHeight : 0
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
            let vc = UINavigationController(rootViewController: DetailPostViewController(model: MockModel.post[indexPath.row],
                                                                                         views: cell.views, handler: { result in
                cell.views += result
            }))
            navigationController?.present(vc, animated: true)
        }
    }
}

extension ProfileViewController: ArrowDidTapDelegate {
    func arrowDidTap() {
        let vc = PhotosViewController(images: MockModel.photos)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//extension ProfileViewController: CustomHeaderDelegate {
//    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
//
//        let rect = header.frame
//        let currentHeaderRect = tableView.convert(rect, to: view)
//        initialImageRect = CGRect
//    }
    
