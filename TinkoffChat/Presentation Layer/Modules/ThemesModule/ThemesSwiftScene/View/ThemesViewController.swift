//
//  ThemesViewController.swift
//  TinkoffChat
//
//  Created by st.i on 16/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

/*
 Чтобы использовать VC на Swift'е:
 1. Поставить галочку в таргете
 2. Раскомментировать код для closure в ConversationsListViewController
 3. Поставить галочку "Inherit module from target" в ThemesStoryboard
 4. Закомментировать #import "ThemesViewController.h" в Bridging-Header
 */

class ThemesViewController: UIViewController {
    
    var didSelectThemeClosure: ((_ selectedTheme: UIColor?) -> Void)?
    var model: Themes?

    override func viewDidLoad() {
        super.viewDidLoad()

        let theme1: UIColor = .white
        let theme2: UIColor = .darkGray
        let theme3: UIColor = .yellow
        
        model = Themes()
        model?.theme1 = theme1
        model?.theme2 = theme2
        model?.theme3 = theme3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedColorData = UserDefaults.standard.data(forKey: "appTheme") {
            do {
                let savedColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData)
                view.backgroundColor = savedColor
            } catch {
                print("Can't unarchive app theme")
            }
        }
    }

    @IBAction func closeViewController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeColorTheme(_ sender: UIButton) {
        var selectedTheme: UIColor?
        switch (sender.tag) {
        case 1:
            selectedTheme = model?.theme1
            break
        case 2:
            selectedTheme = model?.theme2
            break
        case 3:
            selectedTheme = model?.theme3
            break
        default:
            selectedTheme = .white
            break
        }
        didSelectThemeClosure!(selectedTheme)
    }
}
