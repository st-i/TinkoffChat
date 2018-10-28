//
//  MessageModel.swift
//  TinkoffChat
//
//  Created by st.i on 28/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class MessageModel: NSObject {
    var messageID: String?
    var text: String?
    var isIncoming: Bool
    var date: Date?
    
    init(messageID: String?, text: String?, isIncoming: Bool, date: Date?) {
        self.messageID = messageID
        self.text = text
        self.isIncoming = isIncoming
        self.date = date
    }
}
