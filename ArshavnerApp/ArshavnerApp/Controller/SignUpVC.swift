//
//  SignUpVC.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 26.05.21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage


class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static let id = "SignUpVC"
    var realTimeDBRef: DatabaseReference!
    let storage = Storage.storage()
    var storageRef: StorageReference!
    var imageURL: String!
    var imageData: Data?
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnmeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField! //?
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatpswTextField: UITextField!
    @IBOutlet weak var stepcountTextField: UITextField!
    @IBOutlet weak var diseasesTextField: UITextField! //?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realTimeDBRef = Database.database().reference()
        storageRef = storage.reference()

        messageLabel.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
       // navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    MARK: TODO add email validation
    
    @IBAction func signUp(_ sender: UIButton) {
        
//        check if all required fields is filled
        
        if nameTextField.text?.isEmpty == true || surnmeTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || repeatpswTextField.text?.isEmpty == true || stepcountTextField.text?.isEmpty == true {
            messageLabel.isHidden = false
            messageLabel.text = "* End fill in all required fields"
        }
        
//        check if password lenght is not short than 6
        else if passwordTextField.text?.count ?? 1 < 6 {
            messageLabel.isHidden = false
            messageLabel.text = "*Password is to short"
        }
        
//        check if paswords match
        else if passwordTextField.text != repeatpswTextField.text {
            messageLabel.isHidden = false
            messageLabel.text = "* Password does not match"
        }
        
//        if all is ok
        else {
//               register user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self] authResult, error  in
                guard let user = authResult?.user, error == nil else {
                    print(" error: ", error )
                    return
                }
//                if user upload image
                if self.imageData != nil {
                    let fileName = user.uid + ".png"
                    FirebaseManager().uploadImageData(data: self.imageData!, serverFileName: fileName) { (isSuccess, url) in
                        print("uploadImageData: \(isSuccess), \(url)")
                    }
                }
                let myUser = User(name: self.nameTextField.text!, surName: self.surnmeTextField.text!, email: self.emailTextField.text!, phoneNumber: self.phoneTextField.text ?? "", diseases: self.diseasesTextField.text ?? "", stepCount: Int(self.stepcountTextField.text ?? "") ?? 0, imageURL: self.imageURL ?? "")
//                create user info
                let userData = ["name": myUser.name,
                                "surname": myUser.surName,
                                "phone": myUser.phoneNumber,
                                "email": myUser.email,
                                "stepcount": myUser.stepCount,
                                "level": myUser.level.rawValue,
                                "diseases": myUser.diseases
                ]  as NSDictionary
//                save user info in realtime db
                self.realTimeDBRef.child("users").child(user.uid).setValue(userData)

//                navigate to home screen
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id) as HikeListVC
                uid = Auth.auth().currentUser!.uid
                self.navigationController?.pushViewController(secondVC, animated: true)
            })
        }
    }

    @IBAction func addPhoto(_ sender: UIButton) {
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
}


