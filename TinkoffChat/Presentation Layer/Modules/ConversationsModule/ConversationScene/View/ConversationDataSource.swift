//
//  ConversationDataSource.swift
//  TinkoffChat
//
//  Created by st.i on 07/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationDisplayModels!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayModel = conversationDisplayModels![indexPath.row]
        var cellIdentifier: String?
        if displayModel.messageType == .incoming {
            cellIdentifier = "incomingMessageCell"
        }else{
            cellIdentifier = "outcomingMessageCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!) as! MessageCell
        
        cell.messageText = displayModel.message
        return cell
    }
}
