//
//  ConversationCell.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguration: class {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

class ConversationCell: UITableViewCell {
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contactNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        messageLabel.textColor = UIColor.gray
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dateLabel.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ConversationCell: ConversationCellConfiguration {
    var name: String? {
        get {
            return "Unknown"
        }
        set (newName) {
            contactNameLabel.text = newName
        }
    }
    
    var message: String? {
        get {
            return "No messages yet"
        }
        set (newLastMessage) {
            if let lastMessage = newLastMessage {
                messageLabel.text = lastMessage
                messageLabel.font = UIFont.systemFont(ofSize: 17)
            }else{
                messageLabel.text = "No messages yet"
                messageLabel.font = UIFont(name: "Chalkduster", size: 17)
            }
        }
    }
    
    var date: Date? {
        get {
            return Date()
        }
        set (newDate) {
            let formatter = DateFormatter()
            let currentDayBeginningDate = DatesHelper.dateOfCurrentDayBeginning()
            if let newUnwrappedDate = newDate {
                if newUnwrappedDate < currentDayBeginningDate {
                    formatter.dateFormat = "dd MMM"
                }else{
                    formatter.dateFormat = "HH:mm"
                }
                dateLabel.text = formatter.string(from: newUnwrappedDate)
            }else{
                dateLabel.text = nil
            }
        }
    }
    
    var online: Bool {
        get {
            return false
        }
        set (reallyOnline) {
            if reallyOnline {
                backgroundColor = UIColor.yellow.withAlphaComponent(0.1)
            }else{
                backgroundColor = UIColor.white
            }
        }
    }
    
    var hasUnreadMessages: Bool {
        get {
            return false
        }
        set (reallyHasUnreadMessages) {
            if reallyHasUnreadMessages {
                messageLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            }
        }
    }
}
