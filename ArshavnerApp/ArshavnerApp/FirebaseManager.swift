//
//  FirebaseStorageManager.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 09.06.21.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import Firebase

class FirebaseManager {
    
    var dbHandle: DatabaseHandle!
    var realTimeDBRef: DatabaseReference!
    let storage = Storage.storage()
    var storageRef: StorageReference!
    var imageURL: String!
    var imageData: Data?
    static var userInfo: [String: Any]?
    
//    realTimeDBRef = Database.database().reference()
//    storageRef = storage.reference()
    
    public func createUser(user: User) {
//        //               register user
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self] authResult, error  in
//        guard let user = authResult?.user, error == nil else {
//            print(" error: ", error )
//            return
//        }
//        //                if user upload image
//        if self.imageData != nil {
//            let fileName = user.uid + ".png"
//            FirebaseManager().uploadImageData(data: self.imageData!, serverFileName: fileName) { (isSuccess, url) in
//                print("uploadImageData: \(isSuccess), \(url)")
//
//            }
//        }
//        let myUser = User(name: self.nameTextField.text!, surName: self.surnmeTextField.text!, email: self.emailTextField.text!, phoneNumber: self.phoneTextField.text ?? "", diseases: self.diseasesTextField.text ?? "", stepCount: Int(self.stepcountTextField.text ?? "") ?? 0, imageURL: self.imageURL ?? "")
////                create user info
//        let userData = ["name": myUser.name,
//                        "surname": myUser.surName,
//                        "phone": myUser.phoneNumber,
//                        "email": myUser.email,
//                        "stepcount": myUser.stepCount,
//                        "level": myUser.level.rawValue,
//                        "diseases": myUser.diseases
//            ]  as NSDictionary
////                save user info in realtime db
//        self.realTimeDBRef.child("users").child(user.uid).setValue(userData)
//
////                navigate to home screen
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id) as HikeListVC
//        secondVC.uid = Auth.auth().currentUser!.uid
//        self.navigationController?.pushViewController(secondVC, animated: true)
//        })
//    }
        
    }
    
    public func trySignIn(email: String, password: String) -> Bool {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
//            self!.login()
        }
        return self.login()

    }
    func login() -> Bool {
//            if user exist
        if Auth.auth().currentUser != nil {
            print("user exist")
            return true
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let secondVC = storyboard.instantiateViewController(identifier: HikeListVC.id) as HikeListVC
//            secondVC.uid = Auth.auth().currentUser!.uid
//            self.navigationController?.pushViewController(secondVC, animated: true)
        } else {
            return false
        }
    }
    
    public func getUserInfo(uid: String) {//} -> [String:Any]? {
        realTimeDBRef = Database.database().reference()
        storageRef = storage.reference()
        dbHandle = realTimeDBRef.child("users").child(uid).observe(.value) { snapshot in
            let value = snapshot.value as? [String: Any]
            if value != nil {
                //print("not nil", )
                FirebaseManager.userInfo = value
                
            }
        }
        //return self.userInfo

    }
    
    public func uploadImageData(data: Data, serverFileName: String, completionHandler: @escaping (_ isSuccess: Bool, _ url: String?) -> Void) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let directory = "users/"
        let fileRef = storageRef.child(directory + serverFileName)
        
        _ = fileRef.putData(data, metadata: nil) { metadata, error in
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completionHandler(false, nil)
                    return
                }
                // File Uploaded Successfully
                completionHandler(true, downloadURL.absoluteString)
            }
        }
    }

}

