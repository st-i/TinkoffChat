//
//  ConversationTextFieldDelegate.swift
//  TinkoffChat
//
//  Created by st.i on 28/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

extension ConversationViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //при тестировании на симуляторе почему-то не показывается клавиатура
        textFieldBottomConstraint.constant = 10 + 260
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}
