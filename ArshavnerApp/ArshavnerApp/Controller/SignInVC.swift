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

    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedSignIn(_sender: UIButton) {
//        check text fields are nor empty
        guard emailTextField.text?.isEmpty == false else { return }
        guard passwordTextField.text?.isEmpty == false else { return }
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            self!.login()
        }
    }
    
//        TODO: ADD EMAIL VALIDATION

    
    func login(){
//            if user exist
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id) as HikeListVC
            secondVC.uid = Auth.auth().currentUser!.uid
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @IBAction func createAccount(_sender: UIButton) {
        // when this button clicked navigate to signup vc
    }
}

/*
 override func viewDidLoad() {
 super.viewDidLoad()
 setupLoadingControllerUI()
 checkIfUserIsSignedIn()
}

private func checkIfUserIsSignedIn() {

 Auth.auth().addStateDidChangeListener { (auth, user) in
     if user != nil {
         // user is signed in
         // go to feature controller
     } else {
          // user is not signed in
          // go to login controller
     }
 }
}
 */
