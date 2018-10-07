//
//  ConversationsListDataSource.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (conversationsDisplayModels?.count)! / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell") as! ConversationCell
        var diplayModelIndexAddition = 0
        if indexPath.section == 1 {
            diplayModelIndexAddition = 10
        }
        let displayModel = conversationsDisplayModels![diplayModelIndexAddition + indexPath.row]
        cell.name = displayModel.contactName
        cell.message = displayModel.message
        cell.date = displayModel.date
        cell.online = displayModel.online!
        cell.hasUnreadMessages = displayModel.hasUnreadMessages!
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online"
        }else{
            return "History"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
