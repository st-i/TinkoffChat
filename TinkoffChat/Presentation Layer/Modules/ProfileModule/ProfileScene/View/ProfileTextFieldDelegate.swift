//
//  ProfileTextFieldDelegate.swift
//  TinkoffChat
//
//  Created by st.i on 21/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        aboutMeTextView.becomeFirstResponder()
        return true
    }
}
