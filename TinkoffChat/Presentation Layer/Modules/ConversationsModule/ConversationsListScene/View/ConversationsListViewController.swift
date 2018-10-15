//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, ​ThemesViewControllerDelegate {
    
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
    
    //MARK: - Actions
    
    @IBAction func openThemesViewController(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ThemesStoryboard", bundle: nil)
        let themesViewController = storyBoard.instantiateViewController(withIdentifier: "ThemesViewController") as! ThemesViewController
        themesViewController.themesDelegate = self
        let navController = UINavigationController(rootViewController: themesViewController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func openProfileViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let navController = UINavigationController(rootViewController: profileViewController)
        present(navController, animated: true, completion: nil)
    }
    
    func logThemeChanging(selectedTheme: UIColor) {
        Logger.logAppThemeColor(selectedTheme)
    }
    
    //MARK: - ThemesViewControllerDelegate
    
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        logThemeChanging(selectedTheme: selectedTheme)
        UINavigationBar.appearance().backgroundColor = selectedTheme
        UINavigationBar.appearance().barTintColor = selectedTheme
        controller.view.backgroundColor = selectedTheme
        controller.navigationController?.navigationBar.barTintColor = selectedTheme
        
        do {
            try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: selectedTheme, requiringSecureCoding: false), forKey: "appTheme")
        } catch {
            print("Can't save app theme")
        }
        
    }
}
