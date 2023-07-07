//
//  ViewController.swift
//  UserDefaults
//
//  Created by Tsaruk Nick on 4.07.23.
//

import UIKit

final class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    private var imagePicker = UIImagePickerController()
    
    private var name: String = "" {
        didSet{
            nameTextField.text = name
        }
    }
    private var age: Int = 0 {
        didSet {
            if age < 0 {
                age = 0
                ageLabel.text = String(age)
            }
            ageLabel.text = String(age)
        }
    }
    private var image: UIImage? {
        didSet{
            imageViewOutlet.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        nameTextField.delegate = self
        initialState()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageViewOutlet.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func didTap() {
        self.imagePicker.modalPresentationStyle = .pageSheet
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        name = nameTextField.text ?? ""
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        age -= 1
    }
    @IBAction func plusButtonAction(_ sender: Any) {
        age += 1
    }
    @IBAction func saveToUserDefaultsAction(_ sender: Any) {
        let profile = Profile(image: imageViewOutlet.image?.pngData(),
                              name: name,
                              age: age)
        UserDefaultsService.saveProfile(profile)
        showSuccessAlert()
    }
    
    private func initialState() {
        let profile = UserDefaultsService.restoreProfile()
        guard let data = profile.image else { return }
        image = UIImage(data: data)
        guard let getName = profile.name else { return }
        name = getName
        guard let getAge = profile.age else { return }
        age = Int(getAge)
    }
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "Success", message: "Data saved successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        return alert
    }()
    
    private func showSuccessAlert() {
        present(alert, animated: true)
    }
}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let libraryImage = info[.originalImage] as? UIImage else { return }
        image = libraryImage
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}



