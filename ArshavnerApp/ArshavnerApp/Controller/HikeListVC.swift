//
//  HikeListVC.swift
//  ArshavnerApp
//
//  Created by sose yeritsyan on 26.05.21.
//

import UIKit

class HikeListVC: UIViewController {

    static let id = "HikeListVC"
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameAndSurnameLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var HikeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
