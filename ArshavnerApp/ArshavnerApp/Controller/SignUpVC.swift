//
//  SignUpVC.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 26.05.21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpVC: UIViewController {
    static let id = "SignUpVC"
    var realTimeDBRef: DatabaseReference!

    var buttonText = "Sign Up"
    @IBOutlet weak var signUpButton: UIButton!
    
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
        signUpButton.titleLabel?.text = buttonText
        realTimeDBRef = Database.database().reference()
        messageLabel.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
       // navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    MARK:add email validation
    
    @IBAction func signUp(_ sender: UIButton) {
        
//        check if all required fields is filled
        
        if nameTextField.text?.isEmpty == true || surnmeTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || repeatpswTextField.text?.isEmpty == true || stepcountTextField.text?.isEmpty == true {
            messageLabel.isHidden = false
            messageLabel.text = "*End fill in all required fields"
        }
        
//        check if password lenght is not short than 6
        else if passwordTextField.text?.count ?? 1 < 6 {
            messageLabel.isHidden = false
            messageLabel.text = "*Password is to short"
        }
        
//        check if paswords match
        else if passwordTextField.text != repeatpswTextField.text {
            messageLabel.isHidden = false
            messageLabel.text = "*Password does not match"
        }
        
//        if all is ok
        else {
//               register user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self] authResult, error  in
                guard let user = authResult?.user, error == nil else {
                    print(" error: ", error )
                    return
                }
                
                var myUser = User(name: self.nameTextField.text!, surName: self.surnmeTextField.text!, email: self.emailTextField.text!, phoneNumber: self.phoneTextField.text, diseases: self.diseasesTextField.text, stepCount: self.stepcountTextField.text as? Int ?? 0, userPhoto: nil)
//                create user info
                let userData = ["name": myUser.name,
                                "surname": myUser.surName,
                                "phone": myUser.phoneNumber ?? "nil",
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
                secondVC.uid = Auth.auth().currentUser!.uid
                self.navigationController?.pushViewController(secondVC, animated: true)
            })
        }
    }

    @IBAction func addPhoto(_ sender: UIButton) {
    }
    
}
