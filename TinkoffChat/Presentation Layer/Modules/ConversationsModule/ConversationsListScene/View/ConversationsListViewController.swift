//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    @IBOutlet weak var conversationsTableView: UITableView!
    var conversationsDisplayModels: [ConversationDisplayModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinkoff Chat"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(openProfileViewController))
        conversationsDisplayModels = ConversationsListInteractor.createDisplayModels()
        setupTableView()
    }
    
    private func setupTableView() {
        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
    }
    
    @objc func openProfileViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let navController = UINavigationController(rootViewController: profileViewController)
        present(navController, animated: true, completion: nil)
    }
}
