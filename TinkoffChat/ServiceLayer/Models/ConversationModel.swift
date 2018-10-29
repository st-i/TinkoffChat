//
//  ConversationModel.swift
//  TinkoffChat
//
//  Created by st.i on 28/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ConversationModel: NSObject {
    var userName: String?
    var messages: [MessageModel]?
    var userID: String?
    var message: String?
    var isOnline: Bool
    var hasUnreadMessages: Bool
    
    init(userName: String?, messages: [MessageModel]?, userID: String, message: String?, isOnline: Bool, hasUnreadMessages: Bool) {
        self.userName = userName
        self.messages = messages
        self.userID = userID
        self.message = message
        self.isOnline = isOnline
        self.hasUnreadMessages = hasUnreadMessages
    }
}
