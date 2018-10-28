//
//  CommunicationManager.swift
//  TinkoffChat
//
//  Created by st.i on 27/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

protocol ConversationsCommunicatorProtocol: class {
    func conversationsDidUpdate(conversations: [ConversationModel])
}

protocol ConversationCommunicatorProtocol {
    func conversationDidUpdate(conversationMessages: [MessageModel])
}

class CommunicationManager: NSObject, CommunicatorDelegate {
    
    var multipeerCommunicator: MultipeerCommunicator?
    var conversations: [ConversationModel] = []
    var conversationsDelegate: ConversationsCommunicatorProtocol?
    var conversationDelegate: ConversationCommunicatorProtocol?
    
    override init() {
        super.init()
        multipeerCommunicator = MultipeerCommunicator(communicatorDelegate: self)
    }
    
    func didFoundUser(userID: String, userName: String?) {
        if let conversation = conversations.first(where: {$0.userID == userID}) {
            conversation.isOnline = true
        } else {
            let conversation = ConversationModel(userName: userName, messages: [], userID: userID, message: nil, lastMessageDate: nil, isOnline: true, hasUnreadMessages: true)
            conversations.append(conversation)
        }
        conversationsDelegate?.conversationsDidUpdate(conversations: conversations)
//        conversationDelegate?.didUserIsOnline(online: true)
    }
    
    func didLostUser(userID: String) {
        if let conversation = conversations.first(where: {$0.userID == userID}) {
            conversation.isOnline = false
        }
        conversationsDelegate?.conversationsDidUpdate(conversations: conversations)
//        conversationDelegate?.didUserIsOnline(online: false)
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print("failedToStartBrowsingForUsers with error: \(error)")
    }
    
    func failedToStartAdvertising(error: Error) {
        print("failedToStartAdvertising with error: \(error)")
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        for conversation in conversations {
            if conversation.userID == fromUser {
                conversation.messages?.append(MessageModel(messageID: nil, text: text, isIncoming: true, date: Date()))
                conversationDelegate?.conversationDidUpdate(conversationMessages: conversation.messages!)
            }
        }
        conversationsDelegate?.conversationsDidUpdate(conversations: conversations)
    }
}
