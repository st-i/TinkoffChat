//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by st.i on 07/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, ConversationCommunicatorProtocol {
    
    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet var textInputTextField: UITextField!
    @IBOutlet var sendButon: UIButton!
    @IBOutlet var textFieldBottomConstraint: NSLayoutConstraint!
//    var displayModel: ConversationDisplayModel?
//    var conversationDisplayModels: [ConversationMessageDisplayModel]?
    var currentConversation: ConversationModel?
    var communicationManager: CommunicationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = displayModel?.contactName
//        conversationDisplayModels = ConversationInteractor.createDisplayModels()
        navigationItem.title = currentConversation?.userName
        setupTableView()
        communicationManager = CommunicationManager()
        communicationManager?.conversationDelegate = self
    }
    
    private func setupTableView() {
        conversationTableView.allowsSelection = false
        conversationTableView.separatorStyle = .none
        conversationTableView.dataSource = self
        conversationTableView.estimatedRowHeight = 44.0
        conversationTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        if textInputTextField.text != "" {
            let newMessage = MessageModel(messageID: nil, text: textInputTextField.text, isIncoming: false, date: Date())
            currentConversation?.messages?.append(newMessage)
            DispatchQueue.main.async {
//                currentConversation?.messages?.append(newMessage)
                self.conversationTableView.reloadData()
            }
            communicationManager?.multipeerCommunicator?.sendMessage(string: textInputTextField.text!, to: (currentConversation?.userID)!, completionHandler: { (didSend, error) in
                if !didSend {
                    if let unwrappedError = error {
                        print("Message was not sent because of error: \(unwrappedError)")
                    }else{
                        print("Message was not sent because of unknown error")
                    }
                }else{
                    print("Message was successfully sent")
                }
                
            })
            textInputTextField.text = ""
        }
    }
    
    //MARK: - ConversationCommunicatorProtocol
    
    func conversationDidUpdate(conversationMessages: [MessageModel]) {
        currentConversation?.messages = conversationMessages
        DispatchQueue.main.async {
            self.conversationTableView.reloadData()
        }
    }
    
    func userDidChangeState(isOnline: Bool) {
        sendButon.isEnabled = isOnline
    }
}
