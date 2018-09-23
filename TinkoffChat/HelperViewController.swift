//
//  HelperViewController.swift
//  TinkoffChat
//
//  Created by st.i on 22.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class HelperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Just close me"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideViewController))
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    //MARK: Actions
    
    @objc func hideViewController() {
        dismiss(animated: true, completion: nil)
    }
}
