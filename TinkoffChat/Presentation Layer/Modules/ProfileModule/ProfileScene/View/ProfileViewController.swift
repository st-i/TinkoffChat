//
//  ProfileViewController.swift
//  TinkoffChat
//
//  Created by st.i on 30/09/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoButtonImageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var aboutMeTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var gcdButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!

    var imagePickerController = UIImagePickerController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        print("Свойство \'frame\' кнопки \'Редактировать\' в методе init: \(editButton.frame)")
//        При вызове метода init мы должны определить .xib файл для ViewController. Если у нас не получается это сделать, то на этот момент у нас не будет view и outlets. Соответственно, приложение упадет, потому что попытается распаковать (force unwrapping) nil
//        Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Свойство \'frame\' кнопки \'Редактировать\' в методе viewDidLoad: \(editButton.frame)")
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissViewController))
        gcdButton.isHidden = true
        operationButton.isHidden = true
        
        userNameTextField.isEnabled = false
        userNameTextField.delegate = self
        aboutMeTextView.isUserInteractionEnabled = false
        aboutMeTextView.delegate = self
        imagePickerController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Свойство \'frame\' кнопки \'Редактировать\' в методе viewDidAppear: \(editButton.frame)")
//        Frame отличается, потому что во viewDidAppear view уже находится во view hierarchy, в то время как во viewDidLoad - нет
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUserInterface()
    }
    
    //MARK: - UI Setup
    
    private func setupUserInterface() {
        userPhotoImageView.layer.cornerRadius = photoButton.frame.width / 2
        userPhotoImageView.clipsToBounds = true
        userPhotoImageView.image = UIImage(named: "placeholder-user")
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.addTarget(self, action: #selector(chooseProfileImage), for: .touchUpInside)
        
        photoButtonImageView.image = UIImage(named: "slr-camera-2-xxl")

//        descriptionLabel.textColor = UIColor.lightGray
        
        aboutMeTextView.layer.cornerRadius = 15
        
        setupButton(editButton, "Редактировать")
        setupButton(gcdButton, "GCD")
        setupButton(operationButton, "Operation")
    }
    
    private func setupButton(_ button: UIButton, _ title: String) {
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.groupTableViewBackground, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func finishInfoEditing() {
        if userNameTextField.isFirstResponder {
            userNameTextField.resignFirstResponder()
        }
        if aboutMeTextView.isFirstResponder {
            aboutMeTextView.resignFirstResponder()
        }
        userNameTextField.isEnabled = false
        aboutMeTextView.isUserInteractionEnabled = false
        view.frame.origin.y += 250
        editButton.isHidden = false
        gcdButton.isHidden = true
        operationButton.isHidden = true
    }
    
    //MARK: - Button Action
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseProfileImage() {
        print("Выбери изображение профиля")
        showGetPhotoActionSheet()
    }
    
    @IBAction func editProfileAction(_ sender: Any) {
        //better to find keyboard height with the help of UIKeyboardDidShowNotification
        userNameTextField.isEnabled = true
        aboutMeTextView.isUserInteractionEnabled = true
        userNameTextField.becomeFirstResponder()
        view.frame.origin.y -= 250
        editButton.isHidden = true
        gcdButton.isHidden = false
        operationButton.isHidden = false
    }
    
    @IBAction func saveWithGCDAction(_ sender: Any) {
        finishInfoEditing()
    }
    
    @IBAction func saveWithOperationAction(_ sender: Any) {
        finishInfoEditing()
    }
    
    //MARK: - UIAlertController
    
    private func showGetPhotoActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Установить из галереи", style: .default) { (action) in
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
                self.imagePickerController.allowsEditing = false
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: true, completion: nil)
            } else {
                self.showErrorAlert(message: "Произошла ошибка при попытке открыть галерею")
            }
        })
        actionSheet.addAction(UIAlertAction(title: "Сделать фото", style: .default) { (action) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            } else {
                self.showErrorAlert(message: "Произошла ошибка при попытке открыть камеру")
            }
        })
        actionSheet.addAction((UIAlertAction(title: "Отменить", style: .cancel, handler: nil)))
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Упс", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(errorAlert, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhotoImageView.contentMode = .scaleToFill
            userPhotoImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}
