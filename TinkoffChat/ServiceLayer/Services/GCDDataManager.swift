//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by st.i on 22/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class GCDDataManager: UserDataInteractionProtocol {
    
    let userDataService: UserDataService
    
    init(userDataService: UserDataService) {
        self.userDataService = userDataService
    }
    
    func saveUserData(_ userModel: UserModel, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global(qos: .default).async {
            let savingResult = self.userDataService.saveUserData(userModel)
            
            DispatchQueue.main.async {
                completion(savingResult)
            }
        }
    }
    
    func loadUserData(completion: @escaping (UserModel) -> ()) {
        DispatchQueue.global(qos: .default).async {
            let userModel = self.userDataService.loadUserData()
            
            DispatchQueue.main.async {
                completion(userModel)
            }
        }
    }
}
