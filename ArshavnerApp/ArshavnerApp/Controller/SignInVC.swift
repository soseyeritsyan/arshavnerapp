//
//  ViewController.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 5/16/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.isHidden = true
    }

    @IBAction func clickedSignIn(_sender: UIButton) {
                
//        check text fields are not empty
        if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            messageLabel.text = "* End fill in all required fields"
        } else {

            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                guard self != nil else { return }
                if let error = error {
                    self!.messageLabel.isHidden = false
                    self!.messageLabel.text = "\(error.localizedDescription)"
                    print("signin error: ", error.localizedDescription)
                } else {
                    self!.login()
                }
            }
        }
    }
    
    func login(){
//            if user exist
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id) as HikeListVC
            uid = Auth.auth().currentUser!.uid
            self.navigationController?.show(secondVC, sender: nil)//(secondVC, animated: true, completion: nil)//(secondVC, sender: nil)//(secondVC, animated: true)
        }
    }
    
    @IBAction func createAccount(_sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: SignUpVC.id) as SignUpVC
       // secondVC.uid = Auth.auth().currentUser!.uid
        self.navigationController?.show(secondVC, sender: nil)//(secondVC, animated: true)
    }
}
