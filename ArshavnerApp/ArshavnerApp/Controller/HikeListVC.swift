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
    var userInfo: [String:Any]!
    
    var dbHandle: DatabaseHandle!
    var realTimeDBRef: DatabaseReference!

    static let id = "HikeListVC"
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameAndSurnameLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var HikeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realTimeDBRef = Database.database().reference()

        let nibCell = UINib(nibName: "HikeTableViewCell", bundle: nil)
        HikeListTableView.register(nibCell, forCellReuseIdentifier: HikeTableViewCell.id)
//        take data and change userinfo
        dbHandle = realTimeDBRef.child("users").child(uid).observe(.value) { snapshot in
            let value = snapshot.value as? [String: Any]
            if value != nil {
                self.userInfo = value
                self.updateView(info: self.userInfo)

            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        //updateView(info: userInfo)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func updateView(info: [String:Any]) {
        let nameandsurname = "\( info["name"] as! String ) \( info["surname"] as! String)"
        self.nameAndSurnameLabel.text = nameandsurname
        self.stepCountLabel.text = info["stepcount"] as! String
        let levelValue = info["level"] as! Int
        switch levelValue {
        case 1:
            levelLabel.text = "easy"
            break
        case 2:
            levelLabel.text = "middle"
            break
        case 3:
            levelLabel.text = "hard"
            break
        default:
            print("error")
        }

    }
    // MARK: TODO
    @IBAction func editUserInfo(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(identifier: SignUpVC.id) as SignUpVC
//        secondVC.buttonText = Auth.auth().currentUser!.uid
//        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

extension HikeListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HikeTableViewCell.id, for: indexPath) as! HikeTableViewCell
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "HikeDetail")) as! HikeDetailsVC
        let cell = tableView.dequeueReusableCell(withIdentifier: HikeTableViewCell.id, for: indexPath) as! HikeTableViewCell
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
