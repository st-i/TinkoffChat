//
//  OperationDataManager.swift
//  TinkoffChat
//
//  Created by st.i on 22/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class OperationDataManager: UserDataInteractionProtocol {
    
    let userDataService: UserDataService
    
    init(userDataService: UserDataService) {
        self.userDataService = userDataService
    }
    
    func saveUserData(_ userModel: UserModel, completion: @escaping (Bool) -> ()) {
        OperationQueue().addOperation {
            let savingResult = self.userDataService.saveUserData(userModel)
            
            OperationQueue.main.addOperation({
                completion(savingResult)
            })
        }
    }
    
    func loadUserData(completion: @escaping (UserModel) -> ()) {
        OperationQueue().addOperation {
            let userModel = self.userDataService.loadUserData()
            
            OperationQueue.main.addOperation({
                completion(userModel)
            })
        }
    }
}
