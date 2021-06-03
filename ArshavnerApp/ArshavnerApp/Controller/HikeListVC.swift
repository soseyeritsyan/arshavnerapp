//
//  HikeListVC.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 26.05.21.
//

import UIKit
import Firebase
import FirebaseAuth

class HikeListVC: UIViewController {
    
    var uid = ""
   // var user: User!

    let realTimeDBRef = Database.database().reference()

    static let id = "HikeListVC"
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameAndSurnameLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var HikeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.realTimeDBRef.child("users").child(uid).getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                var info = snapshot.value as! [String:Any]
               // self.user.configure(info: info)
                let nameandsurname = "\(String(describing: info["name"])) \(String(describing: info["surname"])))"
                //self.nameAndSurnameLabel.text = nameandsurname
                
               // self.stepCountLabel.text = info["stepcount"] as! String
                
                
            }
            else {
                print("No data available")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension HikeListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
