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

class EditInfoVC: UIViewController {
    
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
        stepcountTextField.text = info["stepcount"] as? String
        diseasesTextField.text = info["diseases"] as? String

    }


}
