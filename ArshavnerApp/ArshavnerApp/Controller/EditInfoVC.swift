//
//  EditInfoViewController.swift
//  ArshavnerApp
//
//  Created by Sose Yeritsyan on 16.06.21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class EditInfoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let id = "EditInfoVC"
    var uid = ""
    let storage = Storage.storage()
    var storageRef: StorageReference!
    var imageURL: String!
    var imageData: Data?
    
    var dbHandle: DatabaseHandle!
    var realTimeDBRef: DatabaseReference!
    
    @IBOutlet weak var nameTextField: UITextField!//
    @IBOutlet weak var surnmeTextField: UITextField!//
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var phoneTextField: UITextField! //?  //
    @IBOutlet weak var stepcountTextField: UITextField! //
    @IBOutlet weak var diseasesTextField: UITextField! //?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realTimeDBRef = Database.database().reference()
        

        dbHandle = realTimeDBRef.child("users").child(uid).observe(.value) { snapshot in
            let value = snapshot.value as? [String: Any]
            if value != nil {
                let userInfo = value
                self.updateView(info: userInfo!)

            }
        }

    }
    
    func updateView(info: [String:Any]) {
        nameTextField.text = info["name"] as? String
        surnmeTextField.text = info["surname"] as? String
        phoneTextField.text = info["phone"] as? String
        stepcountTextField.text = "\(info["stepcount"]!)"
        diseasesTextField.text = info["diseases"] as? String

    }

    @IBAction func changeInfo(_ sender: UIButton) {
//        we change user information if required text fields is not empty
        if nameTextField.text?.isEmpty == false && surnmeTextField.text?.isEmpty == false && stepcountTextField.text?.isEmpty == false {
            self.realTimeDBRef.child("users/\(uid)/name").setValue(nameTextField.text)
            self.realTimeDBRef.child("users/\(uid)/surname").setValue(surnmeTextField.text)
            self.realTimeDBRef.child("users/\(uid)/phone").setValue(phoneTextField.text)
            self.realTimeDBRef.child("users/\(uid)/stepcount").setValue(Int(stepcountTextField.text!))
            self.realTimeDBRef.child("users/\(uid)/diseases").setValue(diseasesTextField.text)
            
//                if user upload image
            if self.imageData != nil {
                print("print image changed!")
                let fileName = self.uid + ".png"
                FirebaseManager().uploadImageData(data: self.imageData!, serverFileName: fileName) { (isSuccess, url) in
                    print("uploadImageData: \(isSuccess), \(url)")
                }
            }
            
            self.navigateHome()
            
        } else {
            messageLabel.text = "Enter all required fields"
        }

    }
    
    @IBAction func changeImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey(rawValue:     "UIImagePickerControllerEditedImage")] as? UIImage {
            if let data = image.pngData() {
//                 convert your UIImage into Data object using png representation
                self.imageData = data
                self.addImageButton.setTitle("Image Selected", for: .normal)
            }

        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
    }
    
    func navigateHome() {
        print("print go home ")
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: HikeListVC.id)) as! HikeListVC
        //uid = self.uid
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
