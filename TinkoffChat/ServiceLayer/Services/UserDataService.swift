//
//  UserDataService.swift
//  TinkoffChat
//
//  Created by st.i on 22/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

protocol UserDataInteractionProtocol {
    func saveUserData(_ userModel: UserModel, completion: @escaping (Bool) -> ())
    func loadUserData(completion: @escaping (UserModel) -> ())
}

class UserDataService: NSObject {
    
    private let userNameKey = "userNameKey"
    private let infoAboutUserKey = "infoAboutUserKey"
    private let userPhotoName = "userPhoto"
    
    func saveUserData(_ userModel: UserModel) -> Bool {
        let userDefaults = UserDefaults.standard
        
        if let userName = userModel.userName {
            userDefaults.set(userName, forKey: userNameKey)
        }

        if let infoAboutUser = userModel.infoAboutUser {
            userDefaults.set(infoAboutUser, forKey: infoAboutUserKey)
        }
        
        if let userPhoto = userModel.userPhoto {
            return saveUserPhoto(userPhoto, userPhotoName)
        }
        
        return true
    }
    
    func loadUserData() -> UserModel {
        let userDefaults = UserDefaults.standard
        
        let userModel = UserModel()
        userModel.userName = userDefaults.string(forKey: userNameKey)
        userModel.infoAboutUser = userDefaults.string(forKey: infoAboutUserKey)
        userModel.userPhoto = loadUserPhoto(userPhotoName)
        
        return userModel
    }
    
    private func saveUserPhoto(_ photo: UIImage, _ photoName: String) -> Bool {
        if let imageData = photo.pngData() {
            let photoPath = getDocumentsDirectoryPath().appendingPathComponent("\(photoName).png")
            do {
                try imageData.write(to: photoPath)
                return true
            } catch {
                print("Error during photo saving process: \(error)")
                return false
            }
        } else {
            return false
        }
    }
    
    private func loadUserPhoto(_ photoName: String) -> UIImage? {
        let photoPath = getDocumentsDirectoryPath().appendingPathComponent("\(photoName).png")
        do {
            let imageData = try Data(contentsOf: photoPath)
            return UIImage(data: imageData)
        } catch {
            print("Error during photo loading process: \(error)")
        }
        return nil
    }
    
    private func getDocumentsDirectoryPath() -> URL {
        let filesPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return filesPaths.first!
    }
}
