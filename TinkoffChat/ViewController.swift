//
//  ViewController.swift
//  TinkoffChat
//
//  Created by st.i on 21.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var logToggle: Bool = true //задание со звездочкой

    override func viewDidLoad() {
        super.viewDidLoad()
        logViewControllerMethod(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logViewControllerMethod(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logViewControllerMethod(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logViewControllerMethod(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logViewControllerMethod(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logViewControllerMethod(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logViewControllerMethod(#function)
    }
    
    //MARK: Helpers
    
    private func logViewControllerMethod(_ methodName: String) {
        if logToggle {
            Logger.logViewControllerMethod(methodName)
        }
    }

    //MARK: Actions
    
    @IBAction func justPushMeAction(_ sender: UIButton) { //вызывает viewWillDisappear и viewDidDisappear
        let helperViewController = HelperViewController()
        let navController = UINavigationController(rootViewController: helperViewController)
        present(navController, animated: true, completion: nil)
    }
}
