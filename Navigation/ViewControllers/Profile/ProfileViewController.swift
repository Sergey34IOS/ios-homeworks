//
//  ProfileViewController.swift
//  Navigation
//
// Created by My Air on 22.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Closure
    
    private lazy var likesHandler: (IndexPath) -> Void = { indexPath in
        let cell = self.tableView.cellForRow(at: indexPath) as! PostTableViewCell
        cell.likes += 1
        self.likesDict[indexPath] = cell.likes
    }

    // MARK: - Model
    
    var likesDict: [IndexPath: Int] = [:]

    var model = PostModel.post
    
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
           
            if let likesByIndex = likesDict[indexPath] {
                cell.likes = likesByIndex
            }
        
            cell.configPost(post: model[indexPath.row], indexPath: indexPath)
            cell.addLikesHandler = likesHandler
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
            let vc = UINavigationController(rootViewController: DetailPostViewController(model: model[indexPath.row],
                                                                                         likes: cell.likes) {
                cell.views += 1
                self.model[indexPath.row].views += 1
            })
            navigationController?.present(vc, animated: true)
        }
    }
}

extension ProfileViewController: ArrowDidTapDelegate {
    func arrowDidTap() {
        let vc = PhotosViewController(images: Model.photos)
        navigationController?.pushViewController(vc, animated: true)
    }
}
