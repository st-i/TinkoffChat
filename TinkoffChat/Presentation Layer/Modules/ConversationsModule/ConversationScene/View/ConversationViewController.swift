//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by st.i on 07/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    @IBOutlet weak var conversationTableView: UITableView!
    var displayModel: ConversationDisplayModel?
    var conversationDisplayModels: [ConversationMessageDisplayModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = displayModel?.contactName
        conversationDisplayModels = ConversationInteractor.createDisplayModels()
        setupTableView()
    }
    
    private func setupTableView() {
        conversationTableView.allowsSelection = false
        conversationTableView.separatorStyle = .none
        conversationTableView.dataSource = self
        conversationTableView.estimatedRowHeight = 44.0
        conversationTableView.rowHeight = UITableView.automaticDimension
    }
}
