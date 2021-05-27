//
//  ViewController.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 5/16/21.
//

import UIKit

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id)
        self.navigationController?.pushViewController(secondVC, animated: true)//(secondVC, sender: self)
//        TO DO: ADD EMAIL VALIDATION

    }
    
    @IBAction func createAccount(_sender: UIButton) {
        // when this button clicked navigate to signup vc
    }
}

