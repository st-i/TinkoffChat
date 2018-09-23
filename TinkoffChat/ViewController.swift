//
//  ViewController.swift
//  TinkoffChat
//
//  Created by st.i on 21.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() { //+
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) { //+
        super.viewWillAppear(animated)
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) { //+
        super.viewDidAppear(animated)
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewWillLayoutSubviews() { //+
        super.viewWillLayoutSubviews()
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewDidLayoutSubviews() { //+
        super.viewDidLayoutSubviews()
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.logViewControllerMethod(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.logViewControllerMethod(#function)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    @IBAction func justPushMeAction(_ sender: UIButton) { //вызывает viewWillDisappear и viewDidDisappear
        let helperViewController = HelperViewController()
        let navController = UINavigationController(rootViewController: helperViewController)
        present(navController, animated: true, completion: nil)
    }
}
