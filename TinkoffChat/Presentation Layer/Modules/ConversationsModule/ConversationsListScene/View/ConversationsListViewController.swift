//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, ​ThemesViewControllerDelegate, ConversationsCommunicatorProtocol {

    @IBOutlet weak var conversationsTableView: UITableView!
//    var conversationsDisplayModels: [ConversationDisplayModel]?
    var onlineConversationsModels: [ConversationModel] = []
    var communicationManager: CommunicationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinkoff Chat"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(openProfileViewController))
//        conversationsDisplayModels = ConversationsListInteractor.createDisplayModels()
        setupTableView()
        communicationManager = CommunicationManager()
        communicationManager?.conversationsDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.conversationsTableView.reloadData()
        }
    }
    
    private func setupTableView() {
        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        setupTableViewHeader()
    }
    
    private func setupTableViewHeader() {
        if onlineConversationsModels.count == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 70))
            let indicatorView = UIActivityIndicatorView(style: .gray)
            indicatorView.center = headerView.center
            indicatorView.startAnimating()
            let hintLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30, height: 26))
            hintLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
            hintLabel.textAlignment = .center
            hintLabel.center = CGPoint(x: indicatorView.center.x, y: indicatorView.center.y + 25)
            hintLabel.text = "Looking for online users"
            hintLabel.textColor = UIColor.lightGray
            headerView.addSubview(indicatorView)
            headerView.addSubview(hintLabel)
            conversationsTableView.tableHeaderView = headerView
            conversationsTableView.separatorStyle = .none
        }else{
            DispatchQueue.main.async {
                self.conversationsTableView.tableHeaderView = nil
                self.conversationsTableView.separatorStyle = .singleLine
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func openThemesViewController(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ThemesStoryboard", bundle: nil)
        let themesViewController = storyBoard.instantiateViewController(withIdentifier: "ThemesViewController") as! ThemesViewController
        
        //Для VC на Objective-C
//        themesViewController!.themesDelegate = self
        
        //Для VC на Swift'е
        themesViewController.didSelectThemeClosure = { [unowned self] (selectedTheme) in
            if let _selectedTheme = selectedTheme {
                self.logThemeChanging(selectedTheme: _selectedTheme)
                self.setupNewAppTheme(selectedTheme: _selectedTheme, controller: themesViewController)
            }
        }
        
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
    
    func setupNewAppTheme(selectedTheme: UIColor, controller: ThemesViewController) {
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
    
    private func sortConversationsByOnlineParameter(unsortedConversations: [ConversationModel]) {
        var onlineConversations = [ConversationModel]()
        for conversationModel in unsortedConversations {
            if conversationModel.isOnline {
                onlineConversations.append(conversationModel)
            }
        }
        onlineConversationsModels = onlineConversations
    }
    
    //MARK: - ThemesViewControllerDelegate
    
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        logThemeChanging(selectedTheme: selectedTheme)
        setupNewAppTheme(selectedTheme: selectedTheme, controller: controller)
    }
    
    //MARK: - ConversationsCommunicatorProtocol
    
    func conversationsDidUpdate(conversations: [ConversationModel]) {
        sortConversationsByOnlineParameter(unsortedConversations: conversations)
        setupTableViewHeader()
        DispatchQueue.main.async {
            self.conversationsTableView.reloadData()
        }
    }
}
