//
//  ConversationsListDelegate.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ConversationsStoryboard", bundle: nil)
            let conversationViewController = storyBoard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
            conversationViewController.displayModel = conversationsDisplayModels![indexPath.row]
            navigationController?.pushViewController(conversationViewController, animated: true)
        }
    }
}
