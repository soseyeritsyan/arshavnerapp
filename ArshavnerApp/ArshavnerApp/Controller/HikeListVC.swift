//
//  HikeListVC.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 26.05.21.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

var uid = ""
var userData = User()
var userInfo: [String:Any]?
//var

class HikeListVC: UIViewController {
    
    var hikeList: [String:Any]!
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
        
            dbHandle = realTimeDBRef.child("users").child(uid).observe(.value) { snapshot in
                let value = snapshot.value as? [String: Any]
                if value != nil {
                    userInfo = value
                    self.updateView(info: userInfo!)
                }
            }
            dbHandle = realTimeDBRef.child("hike").observe(.value) { snapshot in
                let value = snapshot.value as? [String: Any]
                if value != nil {
                    
                    //print("hike list" , value)
    //                self.userInfo = value
    //                self.updateView(info: self.userInfo)

                }
            }
    //        self.updateView(info: self.userInfo)
            
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if userInfo != nil {
            self.showUserPhoto()
        }
        
    }
    
    func updateView(info: [String:Any]) {
        let nameandsurname = "\( info["name"] as! String ) \( info["surname"] as! String)"
        self.nameAndSurnameLabel.text = nameandsurname
        self.stepCountLabel.text = "\(info["stepcount"]!)"
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
//        let imageName = uid + ".png"
//        let reference = Storage.storage().reference(withPath: "users/\(imageName)")
//              reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
//                if let _error = error {
//                   print(_error)
//              } else {
//                if let _data  = data {
//                   let myImage:UIImage! = UIImage(data: _data)
//                     self.userImage.image = myImage
//                }
//             }
//        }
    }
    
    func showUserPhoto() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("users")
        let imageName = uid + ".png"
        let userPhotoReference = imagesRef.child(imageName)
        print("print photo ref", userPhotoReference)
        userPhotoReference.downloadURL { url, error in
            if let err = error {
                print("print I have an error")
                print(err)
            } else {
                print("print url", url)

//                self.userImage.kf.indicatorType = .activity
                self.userImage.kf.setImage(with: url)
            }
        }
        
            }
       // }
//        (maxSize: 18305260, completion: { (data, error) in
//                if let _error = error {
//                print("print I have an error")
//                   print(_error)
//              } else {
//                if let _data  = data {
//                    print("print I have an image")
//                    self.userImage.image =  UIImage(data: _data)
//                }
//             }
//        })
  //  }
    // MARK: TODO
    @IBAction func editUserInfo(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: EditInfoVC.id) as EditInfoVC
        editVC.uid = uid
        self.navigationController?.pushViewController(editVC, animated: true)
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
        
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: HikeDetailsVC.id)) as! HikeDetailsVC
        let cell = tableView.dequeueReusableCell(withIdentifier: HikeTableViewCell.id, for: indexPath) as! HikeTableViewCell
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
